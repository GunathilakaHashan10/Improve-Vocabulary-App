import 'package:flutter/material.dart';
import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/viewModel.dart';
import 'package:improve_vocabulary_app/redux/actions.dart';
import 'package:improve_vocabulary_app/store/appState.dart';
import 'package:improve_vocabulary_app/ui/phrase_example_screen.dart';
import 'package:improve_vocabulary_app/utils/date_formatter.dart';
import 'package:redux/redux.dart';

class PhrasesScreen extends StatefulWidget {
  final Store<AppState> store;
  final ViewModel model;
  PhrasesScreen(this.store, this.model);

  @override
  _PhrasesScreenState createState() => _PhrasesScreenState();
}

class _PhrasesScreenState extends State<PhrasesScreen> {
  var _textEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: widget.model.phrases.length == 0
            ? Center(
                child: Text(
                  "Add phrases",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.5,
                      fontWeight: FontWeight.w500),
                ),
              )
            : Column(
                children: <Widget>[
                  Flexible(
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: widget.model.phrases.length,
                        reverse: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.white10,
                            child: ListTile(
                              title: widget.model.phrases[index],
                              onTap: () {
                                widget.store.dispatch(GetPhraseExampleAction(
                                    widget.model.phrases[index]));
                                var newRoute = MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  Phrase phrase = widget.model.phrases[index];
                                  return PhraseExampleScreen(
                                      widget.model, phrase);
                                });
                                Navigator.of(context).push(newRoute);
                              },
                              onLongPress: () {
                                _deleteDialog(widget.model.phrases[index]);
                              },
                            ),
                          );
                        }),
                  ),
                  Divider(height: 1.0)
                ],
              ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add Phrase",
          backgroundColor: Colors.redAccent,
          child: ListTile(
            title: Icon(Icons.add),
          ),
          onPressed: _showFormDialog,
        ));
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "Phrase",
                  hintText: "eg. How does that sound?",
                  icon: Icon(Icons.note_add)),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            widget.model.onAddPhrase(
                Phrase(_textEditingController.text, dateFormatted()));
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: Text("Save"),
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

  void _deleteDialog(Phrase phrase) {
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
            widget.model.onRemovePhrase(phrase);
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
