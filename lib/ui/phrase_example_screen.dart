import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';
import 'package:improve_vocabulary_app/models/viewModel.dart';
import 'package:improve_vocabulary_app/store/appState.dart';

class PhraseExampleScreen extends StatefulWidget {
  final ViewModel model;
  final Phrase phrase;
  PhraseExampleScreen(this.model, this.phrase);
  @override
  _PhraseExampleScreenState createState() => _PhraseExampleScreenState();
}

class _PhraseExampleScreenState extends State<PhraseExampleScreen> {
  var _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.phrase.phrase),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return viewModel.phraseExamples.length == 0
              ? Center(
                  child: Text(
                    "Add Examples",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 18.5,
                        fontWeight: FontWeight.w500),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Flexible(
                      child: ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: viewModel.phraseExamples.length,
                          reverse: false,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.black54,
                              child: ListTile(
                                title: viewModel.phraseExamples[index],
                                onLongPress: () {
                                  _deleteDialog(
                                      viewModel.phraseExamples[index]);
                                },
                              ),
                            );
                          }),
                    )
                  ],
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Example",
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
        onPressed: _showExampleAddDialog,
      ),
    );
  }

  void _showExampleAddDialog() {
    var alert = AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Usage", icon: Icon(Icons.library_add)),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Add"),
          onPressed: () {
            PhraseExample newPhraseExample =
                new PhraseExample(_textEditingController.text);
            Phrase phrase = widget.phrase;
            widget.model.onAddPhraseExample(newPhraseExample, phrase);
            _textEditingController.clear();
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            _textEditingController.clear();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _deleteDialog(PhraseExample phraseExample) {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
              child: Text(
                "Are you sure?",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.5,
                    fontWeight: FontWeight.bold),
              ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            widget.model.onRemovePhraseExample(phraseExample);
            Navigator.pop(context);
          },
          child: Text("Delete"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
