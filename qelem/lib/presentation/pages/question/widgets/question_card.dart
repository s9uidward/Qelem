import 'package:flutter/material.dart';
import 'package:qelem/domain/models/question_model.dart';

class QuestionCard extends StatelessWidget {
  final QuestionModel question;
  const QuestionCard(this.question, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(0, 14, 16, 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(question.img),
                radius: 40,
              ),
              title: Text(question.heading,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.left),
              subtitle: Text(
                question.userName,
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            alignment: Alignment.centerLeft,
            child: Text(question.questionDescription,
                style: Theme.of(context).textTheme.subtitle2),
          )
        ],
      ),
    );
  }
}