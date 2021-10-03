import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;

  final VoidCallback resetQuiz;

  Result(this.score, this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            child: Text(
              'You have achieved $score.',
            ),
            margin: EdgeInsets.only(top: 10),
          ),
          FlatButton(
            child: Text('Play again.'),
            textColor: Colors.blue[500],
            onPressed: resetQuiz,
          ),
        ],
      ),
    );
  }
}
