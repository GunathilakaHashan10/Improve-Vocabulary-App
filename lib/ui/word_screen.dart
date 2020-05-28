import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:improve_vocabulary_app/models/viewModel.dart';
import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/store/appState.dart';
import 'package:improve_vocabulary_app/ui/word_example_screen.dart';
import 'package:improve_vocabulary_app/utils/date_formatter.dart';
import 'package:redux/redux.dart';
import 'package:improve_vocabulary_app/redux/actions.dart';

class WordScreen extends StatefulWidget {
  final Store<AppState> store;
  final ViewModel model;
  WordScreen(this.store, this.model);

  @override
  _WordScreenState createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  var _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: widget.model.words.length == 0
            ? Center(
                child: Text(
                  "Add words",
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
                        itemCount: widget.model.words.length,
                        reverse: false,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.white10,
                            child: ListTile(
                              title: widget.model.words[index],
                              onTap: () {
                                widget.store.dispatch(GetWordExampleAction(
                                    widget.model.words[index]));
                                var newRoute = MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  Word word = widget.model.words[index];
                                  return WordExampleScreen(widget.model, word);
                                });
                                Navigator.of(context).push(newRoute);
                              },
                              onLongPress: () {
                                _deleteDialog(widget.model.words[index]);
                              },
                            ),
                          );
                        }),
                  ),
                  Divider(height: 1.0)
                ],
              ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add Word",
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
                  labelText: "Word",
                  hintText: "eg. verb, noun, adj..",
                  icon: Icon(Icons.note_add)),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            widget.model.onAddWord(
                Word(_textEditingController.text, dateFormatted(), "Verb"));
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

  void _deleteDialog(Word word) {
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
            widget.model.onRemoveWord(word);
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
