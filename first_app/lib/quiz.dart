import 'package:first_app/question.dart';
import 'package:flutter/material.dart';

import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function selectAnswerHandler;

  Quiz(this.questions, this.questionIndex, this.selectAnswerHandler);

  @override
  Widget build(BuildContext context) {
    Map<String, Object> question = questions[questionIndex];

    return Column(
      children: [
        Question(question['question'] as String),
        ...(question['answers'] as List<Map<String, Object>>)
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key;
          Map<String, Object> answer = entry.value;

          return Answer(
            answer['text'] as String,
            selectAnswerHandler,
            answer['score'] as int,
          );
        }),
      ],
    );
  }
}
