import 'dart:async';
import 'dart:io';

import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';
import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper.internal();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "vocabulary.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE Word("
        "_id INTEGER PRIMARY KEY,"
        "word TEXT,"
        "dateCreated TEXT,"
        "wordType TEXT)");

    await db.execute("CREATE TABLE Phrase("
        "_id INTEGER PRIMARY KEY,"
        "phrase TEXT,"
        "dateCreated TEXT)");

    await db.execute("CREATE TABLE WordExample("
        "_id INTEGER PRIMARY KEY,"
        "wordId INTEGER,"
        "example TEXT,"
        "FOREIGN KEY(wordId) REFERENCES Word(_id))");

    await db.execute("CREATE TABLE PhraseExample("
        "_id INTEGER PRIMARY KEY,"
        "phraseId INTEGER,"
        "example TEXT,"
        "FOREIGN KEY(phraseId) REFERENCES Phrase(_id))");
  }
  
  Future dropTable(String tableName) async {
    var dbClient = await db;
    await dbClient.execute("DROP TABLE $tableName");
  }

  Future<int> saveWord(Word word) async {
      var dbClient = await db;
      int res = await dbClient.insert("Word", word.toMap());
      return res;
  }

  Future<List> getWords() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM Word ORDER BY word ASC");
    return result.toList();
  }

  Future<Word> getWord(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM Word WHERE _id = $id");
    if (result.length == 0) return null;
    return new Word.fromMap(result.first);
  }

  Future<int> getWordPrimaryKey(String wordName) async {
    var dbClient = await db;
    var result = await dbClient.query("Word", columns: ["_id"],where: "word = ?", whereArgs: [wordName]);
    return result[0]["_id"];
  }

  Future<int> deleteWord(String wordName) async {
    var dbClient = await db;
    return await dbClient.delete("Word", where: "word = ?", whereArgs: [wordName]);
  }

  Future<int> saveWordExample(Word word, WordExample wordExample) async {
    var dbClient = await db;
    int wordId = await getWordPrimaryKey(word.word);
    wordExample.wordId = wordId;
    int res = await dbClient.insert("WordExample", wordExample.toMap());
    return res;
  }

  Future<List> getWordExamples(Word word) async {
    var dbClient = await db;
    int wordId = await getWordPrimaryKey(word.word);
    var result = await dbClient.query("WordExample", columns: ["_id", "wordId", "example"], where: "wordId = ?", whereArgs: [wordId]);
    return result.toList();
  }

  Future<List> getAllExamples() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM WordExample ORDER BY example ASC");
    return result.toList();
  }

  Future<int> deleteWordExample(String example) async {
    var dbClient = await db;
    return await dbClient.delete("WordExample", where: "example = ? ", whereArgs: [example]);
  }

  Future deleteAllExamples(Word word) async {
    var dbClient = await db;
    int wordId = await getWordPrimaryKey(word.word);
    var result = await dbClient.query("WordExample", columns: ["_id"], where:"wordId = ?", whereArgs: [wordId]);
    if(result.toList().length > 0) {
      return await dbClient.delete("WordExample", where: "wordId = ?", whereArgs: [wordId]);
    }
    return;
  }

  Future<int> addPhrase(Phrase phrase) async {
    var dbClient = await db;
    int res = await dbClient.insert("Phrase", phrase.toMap());
    return res;
  }

  Future<List> getPhrases() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM Phrase ORDER BY phrase ASC");
    return result.toList();
  }

  Future<int> getPhrasePrimaryKey(String phraseName) async {
    var dbClient = await db;
    var result = await dbClient.query("Phrase", columns: ["_id"],where: "phrase = ?", whereArgs: [phraseName]);
    return result[0]["_id"];
  }

  Future<int> deletePhrase(String phraseName) async {
    var dbClient = await db;
    return await dbClient.delete("Phrase", where: "phrase = ?", whereArgs: [phraseName]);
  }

  Future<int> addPhraseExample(Phrase phrase, PhraseExample phraseExample) async {
    var dbClient = await db;
    int phraseId = await getPhrasePrimaryKey(phrase.phrase);
    phraseExample.phraseId = phraseId;
    int res = await dbClient.insert("PhraseExample", phraseExample.toMap());
    return res;
  }

  Future<List> getPhraseExamples(Phrase phrase) async {
    var dbClient = await db;
    int phraseId = await getPhrasePrimaryKey(phrase.phrase);
    var result = await dbClient.query("PhraseExample", columns: ["_id", "phraseId", "example"], where: "phraseId = ?", whereArgs: [phraseId]);
    return result.toList();
  }

  Future<List> getAllPhraseExamples() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM PhraseExample ORDER BY example ASC");
    return result.toList();
  }

  Future<int> deletePhraseExample(String example) async {
    var dbClient = await db;
    return await dbClient.delete("PhraseExample", where: "example = ? ", whereArgs: [example]);
  }

  Future deleteAllPhraseExamples(Phrase phrase) async {
    var dbClient = await db;
    int phraseId = await getPhrasePrimaryKey(phrase.phrase);
    var result = await dbClient.query("PhraseExample", columns: ["_id"], where:"phraseId = ?", whereArgs: [phraseId]);
    if(result.toList().length > 0) {
      return await dbClient.delete("PhraseExample", where: "phraseId = ?", whereArgs: [phraseId]);
    }
    return;
  }

}
