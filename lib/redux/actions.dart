import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';
import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';

class AddWordAction {
  static int _id = 0;
  final Word wordItem;
  AddWordAction(this.wordItem) {
    _id++;
  }
  int get id => _id;
}

class RemoveWordAction {
  final Word word;
  RemoveWordAction(this.word);
}

class GetWordsAction {}

class LoadedWordsAction {
  final List<Word> words;
  LoadedWordsAction(this.words);
}

class AddWordExampleAction {
  static int _id = 0;
  final WordExample wordExample;
  final Word word;
  AddWordExampleAction(this.wordExample, this.word){
    _id++;
  }
  int get id => _id;
}

class RemoveWordExampleAction {
  final WordExample wordExample;
  RemoveWordExampleAction(this.wordExample);
}

class GetWordExampleAction {
  final Word word;
  GetWordExampleAction(this.word);
}

class LoadedWordExampleAction {
  final List<WordExample> wordExamples;
  LoadedWordExampleAction(this.wordExamples);
}

class AddPhraseAction {
  static int _id = 0;
  final Phrase phraseItem;
  AddPhraseAction(this.phraseItem) {
    _id++;
  }
  int get id => _id;
}

class RemovePhraseAction {
  final Phrase phrase;
  RemovePhraseAction(this.phrase);
}

class GetPhrasesAction {}

class LoadedPhrasesAction {
  final List<Phrase> phrases;
  LoadedPhrasesAction(this.phrases);
}

class AddPhraseExampleAction {
  static int _id = 0;
  final PhraseExample phraseExample;
  final Phrase phrase;
  AddPhraseExampleAction(this.phraseExample, this.phrase){
    _id++;
  }
  int get id => _id;
}

class RemovePhraseExampleAction {
  final PhraseExample phraseExample;
  RemovePhraseExampleAction(this.phraseExample);
}

class GetPhraseExampleAction {
  final Phrase phrase;
  GetPhraseExampleAction(this.phrase);
}

class LoadedPhraseExampleAction {
  final List<PhraseExample> phraseExamples;
  LoadedPhraseExampleAction(this.phraseExamples);
}