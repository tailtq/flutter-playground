import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final String answerText;

  final Function selectAnswerHandler;

  final int score;

  Answer(this.answerText, this.selectAnswerHandler, this.score);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          child: Text(answerText),
          color: Colors.blue[400],
          textColor: Colors.white,
          onPressed: () {
            selectAnswerHandler(score);
          },
        ),
    );
  }
}
