import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  int score;

  Result(this.score);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('You have achieved $score.'),
    );
  }
}
