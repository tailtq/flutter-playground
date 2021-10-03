import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String questionTitleText;

  Question(this.questionTitleText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      child: Text(
        questionTitleText,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
