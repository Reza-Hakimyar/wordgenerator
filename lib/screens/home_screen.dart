import 'package:flutter/material.dart';

import 'random_words.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RandomWords();
  }
}
