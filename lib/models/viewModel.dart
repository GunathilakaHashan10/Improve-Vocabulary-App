import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';
import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';
import 'package:improve_vocabulary_app/redux/actions.dart';
import 'package:improve_vocabulary_app/store/appState.dart';
import 'package:redux/redux.dart';

class ViewModel {
  final List<Word> words;
  final Function(Word) onAddWord;
  final Function(Word) onRemoveWord;

  final List<WordExample> wordExamples;
  final Function(WordExample, Word) onAddWordExample;
  final Function(WordExample) onRemoveWordExample;

  final List<Phrase> phrases;
  final Function(Phrase) onAddPhrase;
  final Function(Phrase) onRemovePhrase;

  final List<PhraseExample> phraseExamples;
  final Function(PhraseExample, Phrase) onAddPhraseExample;
  final Function(PhraseExample) onRemovePhraseExample;

  ViewModel({
    this.words,
    this.onAddWord,
    this.onRemoveWord,
    this.wordExamples,
    this.onAddWordExample,
    this.onRemoveWordExample,
    this.phrases,
    this.onAddPhrase,
    this.onRemovePhrase,
    this.phraseExamples,
    this.onAddPhraseExample,
    this.onRemovePhraseExample
  });

  factory ViewModel.create(Store<AppState> store) {
    _onAddWord(Word word) {
      store.dispatch(AddWordAction(word));
    }

    _onRemoveWord(Word word) {
      store.dispatch(RemoveWordAction(word));
    }

    _onAddWordExample(WordExample wordExample, Word word) {
      store.dispatch(AddWordExampleAction(wordExample, word));
    }

    _onRemoveWordExample(WordExample wordExample) {
      store.dispatch(RemoveWordExampleAction(wordExample));
    }

    _onAddPhrase(Phrase phrase) {
      store.dispatch(AddPhraseAction(phrase));
    }

    _onRemovePhrase(Phrase phrase) {
      store.dispatch(RemovePhraseAction(phrase));
    }

    _onAddPhraseExample(PhraseExample phraseExample, Phrase phrase) {
      store.dispatch(AddPhraseExampleAction(phraseExample, phrase));
    }

    _onRemovePhraseExample(PhraseExample phraseExample) {
      store.dispatch(RemovePhraseExampleAction(phraseExample));
    }

    return ViewModel(
        words: store.state.words,
        onAddWord: _onAddWord,
        onRemoveWord: _onRemoveWord,
        wordExamples: store.state.wordExamples,
        onAddWordExample: _onAddWordExample,
        onRemoveWordExample: _onRemoveWordExample,
        phrases: store.state.phrases,
        onAddPhrase: _onAddPhrase,
        onRemovePhrase: _onRemovePhrase,
        phraseExamples: store.state.phraseExamples,
        onAddPhraseExample: _onAddPhraseExample,
        onRemovePhraseExample: _onRemovePhraseExample
    );
  }
}

