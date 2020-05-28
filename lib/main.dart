import 'package:flutter/material.dart';
import 'package:improve_vocabulary_app/ui/home_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:improve_vocabulary_app/redux/reducers.dart';
import 'package:improve_vocabulary_app/redux/actions.dart';
import 'package:improve_vocabulary_app/redux/middleware.dart';
import 'package:improve_vocabulary_app/store/appState.dart';

void main() async {
  final Store<AppState> store = Store<AppState>(
    appStateReducer,
    initialState: AppState.initialState(),
    middleware: [appStateMiddleware]
  );

  runApp(StoreProvider(
    store: store,
    child: MaterialApp(
      title: "Improve Vocabulary",
      debugShowCheckedModeBanner: false,
      home: StoreBuilder<AppState>(
        onInit: (store) {
          store.dispatch(GetWordsAction());
          store.dispatch(GetPhrasesAction());
        },
        builder: (BuildContext context, Store<AppState> store) =>
          Home(store),
      ),
    ),
  ));
}