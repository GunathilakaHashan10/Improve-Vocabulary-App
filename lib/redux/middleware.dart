import 'package:improve_vocabulary_app/models/phrase.dart';
import 'package:improve_vocabulary_app/models/phraseExample.dart';
import 'package:improve_vocabulary_app/models/word.dart';
import 'package:improve_vocabulary_app/models/wordExample.dart';
import 'package:improve_vocabulary_app/store/appState.dart';
import 'package:redux/redux.dart';
import 'actions.dart';
import 'package:improve_vocabulary_app/utils/Database_helper.dart';

void appStateMiddleware(Store<AppState> store, action, NextDispatcher next) async {
  next(action);
  var db = new DatabaseHelper();

  if(action is AddWordAction) {
    await db.saveWord(action.wordItem);
  }

  if(action is RemoveWordAction) {
    await db.deleteAllExamples(action.word);
    await db.deleteWord(action.word.word);
  }

  if(action is GetWordsAction) {
   List words = await db.getWords();
   List<Word> wordList = <Word>[];
   words.forEach((word) {
     wordList.add(Word.map(word));
   });
   store.dispatch(LoadedWordsAction(wordList));
  }

  if(action is AddWordExampleAction) {
    await db.saveWordExample(action.word, action.wordExample);
  }

  if(action is RemoveWordExampleAction) {
    await db.deleteWordExample(action.wordExample.example);
  }

  if(action is GetWordExampleAction) {
    List wordExamples = await db.getWordExamples(action.word);
    List<WordExample> wordExamplesList = <WordExample>[];
    wordExamples.forEach((wordExample){
      wordExamplesList.add(WordExample.map(wordExample));
    });
    store.dispatch(LoadedWordExampleAction(wordExamplesList));
    wordExamplesList = <WordExample>[];
  }

  if(action is AddPhraseAction) {
    await db.addPhrase(action.phraseItem);
  }

  if(action is RemovePhraseAction) {
    await db.deleteAllPhraseExamples(action.phrase);
    await db.deletePhrase(action.phrase.phrase);
  }

  if(action is GetPhrasesAction) {
    List phrases = await db.getPhrases();
    List<Phrase> phraseList = <Phrase>[];
    phrases.forEach((phrase) {
      phraseList.add(Phrase.map(phrase));
    });
    store.dispatch(LoadedPhrasesAction(phraseList));
  }

  if(action is AddPhraseExampleAction) {
    await db.addPhraseExample(action.phrase, action.phraseExample);
  }

  if(action is RemovePhraseExampleAction) {
    await db.deletePhraseExample(action.phraseExample.example);
  }

  if(action is GetPhraseExampleAction) {
    List phraseExamples = await db.getPhraseExamples(action.phrase);
    List<PhraseExample> phraseExamplesList = <PhraseExample>[];
    phraseExamples.forEach((phraseExample){
      phraseExamplesList.add(PhraseExample.map(phraseExample));
    });
    store.dispatch(LoadedPhraseExampleAction(phraseExamplesList));
    phraseExamplesList = <PhraseExample>[];
  }
}

