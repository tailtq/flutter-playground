import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _questionIndex = 0;
  int _score = 0;

  static const _questions = [
    {
      'question': 'Which name of Alex is correct?',
      'answers': [
        {'text': 'Alexandra', 'score': 5},
        {'text': 'Alessandra', 'score': 0},
        {'text': 'Alexander', 'score': 10},
      ],
    },
    {
      'question': 'What kind of food does Alex enjoy?',
      'answers': [
        {'text': 'Milk tea', 'score': 15},
        {'text': 'Sausauge', 'score': 10},
        {'text': 'Chips', 'score': 5},
      ],
    },
  ];

  void _selectAnswer(int score) {
    setState(() {
      if (this._questionIndex < _questions.length) {
        this._score += score;
        this._questionIndex += 1;
      }
    });
  }

  void _resetQuiz() {
    setState(() {
      this._score = 0;
      this._questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: BarTitleWidget(),
        ),
        body: this._questionIndex < _questions.length
            ? Quiz(
                _questions,
                _questionIndex,
                this._selectAnswer,
              )
            : Result(this._score, this._resetQuiz),
      ),
    );
  }
}

class BarTitleWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Text('Hello Kitty');
  }
}
