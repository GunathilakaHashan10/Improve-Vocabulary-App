import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:improve_vocabulary_app/models/viewModel.dart';
import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';
import 'package:improve_vocabulary_app/store/appState.dart';

class WordExampleScreen extends StatefulWidget {
  final ViewModel model;
  final Word word;
  WordExampleScreen(this.model, this.word);
  @override
  _WordExampleScreenState createState() => _WordExampleScreenState();
}

class _WordExampleScreenState extends State<WordExampleScreen> {
  var _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word.word),
        backgroundColor: Colors.black54,
        centerTitle: true,
      ),
      body: StoreConnector<AppState, ViewModel>(
        converter: (store) => ViewModel.create(store),
        builder: (BuildContext context, ViewModel viewModel) {
          return viewModel.wordExamples.length == 0
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
                          itemCount: viewModel.wordExamples.length,
                          reverse: false,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: Colors.black54,
                              child: ListTile(
                                title: viewModel.wordExamples[index],
                                onLongPress: () {
                                  _deleteDialog(viewModel.wordExamples[index]);
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
                    labelText: "Usage",
                    hintText: "Eg. I eat rice",
                    icon: Icon(Icons.library_add)),
              ),
            )
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Add"),
          onPressed: () {
            WordExample newWordExample =
                new WordExample(_textEditingController.text);
            Word word = widget.word;
            widget.model.onAddWordExample(newWordExample, word);
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

  void _deleteDialog(WordExample wordExample) {
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
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            widget.model.onRemoveWordExample(wordExample);
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
