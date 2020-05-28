import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WordExample extends StatelessWidget {
  int _id;
  int wordId;
  String _example;

  WordExample(this._example);

  int get id => _id;
  int get getWordId => wordId;
  String get example => _example;



  WordExample.map(dynamic obj) {
    this._id = obj["id"];
    this._example = obj["example"];
    this.wordId = obj["wordId"];
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map["example"] = _example;
    map["wordId"] = wordId;
    if(_id != null) {
      map["id"] = _id;
    }
    return map;
  }

  WordExample.fromMap(Map<String, dynamic> map) {
    this._id = map["id"];
    this._example = map["example"];
    this.wordId = map["wordId"];
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
