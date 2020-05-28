import 'package:flutter/material.dart';

class Word extends StatelessWidget {
  int _id;
  String _word;
  String _dateCreated;
  String _wordType;

  Word(String word, String dateCreated, String wordType) {
    this._word = word;
    this._dateCreated = dateCreated;
    this._wordType = wordType;
  }

  int get id => _id;
  String get word => _word;
  String get dateCreated => _dateCreated;
  String get wordType => _wordType;


  Word.map(dynamic obj) {
    this._id = obj["id"];
    this._word = obj["word"];
    this._dateCreated = obj["dateCreated"];
    this._wordType = obj["wordType"];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["word"] = _word;
    map["dateCreated"] = _dateCreated;
    map["wordType"] = _wordType;
    if(_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Word.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._word = map["word"];
    this._dateCreated = map["dateCreated"];
    this._wordType = map["wordType"];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _word,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.9),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(
                  "$_wordType",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13.5,
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          )
        ],
      ),
    );
  }


}
