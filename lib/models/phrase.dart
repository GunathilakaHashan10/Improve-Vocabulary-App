import 'package:flutter/material.dart';

class Phrase extends StatelessWidget {
  int _id;
  String _phrase;
  String _dateCreated;

  Phrase(this._phrase, this._dateCreated);

  int get id => _id;
  String get phrase => _phrase;
  String get dateCreated => _dateCreated;

  Phrase.map(dynamic obj) {
    this._id = obj["id"];
    this._phrase = obj["phrase"];
    this._dateCreated = obj["dateCreated"];
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map["phrase"] = _phrase;
    map["dateCreated"] = _dateCreated;
    if (_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  Phrase.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._phrase = map["phrase"];
    this._dateCreated = map["dateCreated"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _phrase,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.9),
          )
        ],
      ),
    );
  }
}
