import 'package:flutter/material.dart';
import 'package:improve_vocabulary_app/store/appState.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:improve_vocabulary_app/ui/phrases_screen.dart';
import 'package:improve_vocabulary_app/ui/word_screen.dart';
import 'package:improve_vocabulary_app/models/viewModel.dart';

class Home extends StatefulWidget {
  final Store<AppState> store;
  Home(this.store);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Vocabulary"),
          centerTitle: true,
          backgroundColor: Colors.black54,
        ),
        body: StoreConnector<AppState, ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context, ViewModel viewModel) =>
              _selectedIndex == 0
                  ? WordScreen(widget.store, viewModel)
                  : PhrasesScreen(widget.store, viewModel),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black54,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.featured_play_list,
                color: Colors.white,
              ),
              title: Text(
                "Words",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
              ),
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.featured_play_list,
                  color: Colors.white,
                ),
                title: Text("Phrases",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w800)))
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
