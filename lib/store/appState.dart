import 'package:flutter/foundation.dart';
import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';
import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';

class AppState {
    List<Word> words;
    List<WordExample> wordExamples;
    List<Phrase> phrases;
    List<PhraseExample> phraseExamples;

    AppState({
        @required this.words,
        @required this.wordExamples,
        @required this.phrases,
        @required this.phraseExamples
    });

    AppState.initialState() {
        words = List.unmodifiable(<Word>[]);
        wordExamples = List.unmodifiable(<WordExample>[]);
        phrases = List.unmodifiable(<Phrase>[]);
        phraseExamples = List.unmodifiable(<PhraseExample>[]);
    }
}