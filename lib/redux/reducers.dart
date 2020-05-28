import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';
import 'package:improve_vocabulary_app/store/appState.dart';
import 'package:improve_vocabulary_app/redux/actions.dart';
import 'package:improve_vocabulary_app/models/word.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
      words: wordReducer(state.words, action),
      wordExamples: wordExampleReducer(state.wordExamples, action),
      phrases: phraseReducer(state.phrases, action),
      phraseExamples: phraseExampleReducer(state.phraseExamples, action)
  );
}

List<Word> wordReducer(List<Word> state, action) {
  if (action is AddWordAction) {
    return []
      ..addAll(state)
      ..add(action.wordItem);
  }

  if (action is RemoveWordAction) {
    return List.unmodifiable(List.from(state)..remove(action.word));
  }

  if (action is LoadedWordsAction) {
    return action.words;
  }
  return state;
}

List<WordExample> wordExampleReducer(List<WordExample> state, action) {
  if (action is AddWordExampleAction) {
    return []
      ..addAll(state)
      ..add(action.wordExample);
  }

  if (action is RemoveWordExampleAction) {
    return List.unmodifiable(List.from(state)..remove(action.wordExample));
  }

  if (action is LoadedWordExampleAction) {
    return action.wordExamples;
  }

  return state;
}

List<Phrase> phraseReducer(List<Phrase> state, action) {
  if (action is AddPhraseAction) {
    return []
      ..addAll(state)
      ..add(action.phraseItem);
  }

  if (action is RemovePhraseAction) {
    return List.unmodifiable(List.from(state)..remove(action.phrase));
  }

  if (action is LoadedPhrasesAction) {
    return action.phrases;
  }

  return state;
}

List<PhraseExample> phraseExampleReducer(List<PhraseExample> state, action) {
  if (action is AddPhraseExampleAction) {
    return []
      ..addAll(state)
      ..add(action.phraseExample);
  }

  if(action is RemovePhraseExampleAction) {
    return List.unmodifiable(List.from(state)..remove(action.phraseExample));
  }

  if(action is LoadedPhraseExampleAction) {
    return action.phraseExamples;
  }

  return state;
}
