import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return ListTile(
          title: Text(pair.asPascalCase),
        );
      });
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(context: context, tiles: tiles).toList()
          : <Widget>[];
      return Scaffold(
        appBar: AppBar(title: const Text(saved)),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  ListView _buildListView() {
    return ListView.builder(
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, int i) {
          if (i.isOdd) {
            return const Divider();
          }
          final _index = i ~/ 2;
          if (_index >= _suggestions.length) {
            _suggestions.addAll(
              generateWordPairs().take(10),
            );
          }
          return _buildCard(_suggestions[_index], _index + 1);
        });
  }

  Widget _buildCard(WordPair wordPair, int count) {
    final _alreadySaved = _saved.contains(wordPair);
    return ListTile(
      title: Text(wordPair.asPascalCase),
      leading: Text('$count'),
      trailing: Icon(
        _alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: _alreadySaved ? Colors.red : null,
        semanticLabel: _alreadySaved ? 'Remove from saved' : 'save',
      ),
      onTap: () {
        setState(() {
          if (_alreadySaved) {
            _saved.remove(wordPair);
          } else {
            _saved.add(wordPair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(title, style: textStyle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
                icon: const Icon(Icons.favorite_border, color: Colors.red),
                onPressed: _pushSaved,
                tooltip: saved),
          ),
        ],
      ),
      body: _buildListView(),
    );
  }
}
