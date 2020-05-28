import 'package:flutter/material.dart';

class PhraseExample extends StatelessWidget {
  int _id;
  int phraseId;
  String _example;

  PhraseExample(this._example);

  int get id => _id;
  int get getPhraseId => phraseId;
  String get example => _example;

  PhraseExample.map(dynamic obj) {
    this._id = obj["id"];
    this._example = obj["example"];
    this.phraseId = obj["phraseId"];
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map["example"] = _example;
    map["phraseId"] = phraseId;
    if(_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  PhraseExample.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._example = map["example"];
    this.phraseId = map["phraseId"];
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              _example,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.9,
                  fontStyle: FontStyle.italic
              ),
            ),
          )
        ],
      ),
    );
  }

}
