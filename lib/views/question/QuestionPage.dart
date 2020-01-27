import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:question_app/models/Question.dart';
import 'package:question_app/services/QuestionService.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  _QuestionPageState createState() {
    return _QuestionPageState();
  }
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var questionService = Provider.of<QuestionService>(context);
    var questions = questionService.questions;
    var score = questionService.score;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Le Quizz'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: !questionService.ended
              ? this.questionBloc(questions, questionService, context)
              : <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text("Vous avez terminé !!!"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                        'Votre score est de $score/${questions.length}'),
                  ),
                  new RaisedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                      questionService.reset();
                    },
                    child: new Text('TERMINER'),
                  )
                ],
        ),
      ),
    );
  }

  List<Widget> questionBloc(List<Question> questions,
      QuestionService questionService, BuildContext context) {
    var questions = questionService.questions;
    var iterator = questionService.questionIterator;
    var score = questionService.score;

    return <Widget>[
      new SizedBox(height: 20.0),
      new Text('Question numéro ${questions.indexOf(iterator.current) + 1}'),
      new SizedBox(
        height: 20.0,
      ),
      new Text('Score $score/${questions.indexOf(iterator.current)}'),
      new SizedBox(
        height: 20.0,
      ),
      new Card(
        child: Container(
          child: new Image.asset(
            iterator.current?.resolveImagePath(),
            fit: BoxFit.cover,
          ),
          width: MediaQuery.of(context).size.height / 2.3,
          height: MediaQuery.of(context).size.height / 2.3,
        ),
        borderOnForeground: true,
        elevation: 15.0,
      ),
      new SizedBox(
        height: 20.0,
      ),
      new Text(
        '${iterator.current?.libelle}',
        textAlign: TextAlign.center,
      ),
      new SizedBox(
        height: 15.0,
      ),
      new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new RaisedButton(
              child: new Text('Vrai'),
              color: Colors.blue,
              onPressed: () => this.showResult(true, questionService)),
          new RaisedButton(
              child: new Text('Faux'),
              color: Colors.blue,
              onPressed: () => this.showResult(false, questionService))
        ],
      )
    ];
  }

  Future<Null> showResult(bool rep, QuestionService service) async {
    var iterator = service.questionIterator;
    bool answer = rep == iterator.current.reponse;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext ctx) {
          return new SimpleDialog(
            title: new Text(
              answer ? 'C\'est gagné !' : 'Oups! perdu...',
              textScaleFactor: 1.1,
              textAlign: TextAlign.center,
              style: new TextStyle(color: answer ? Colors.green : Colors.red),
            ),
            contentPadding: EdgeInsets.all(10.0),
            children: <Widget>[
              new Card(
                child: Container(
                  child: new Image.asset(
                    answer
                        ? 'assets/images/vrai.jpg'
                        : 'assets/images/faux.jpg',
                    fit: BoxFit.cover,
                  ),
                  width: MediaQuery.of(ctx).size.height / 2.3,
                  height: MediaQuery.of(ctx).size.height / 3.5,
                ),
                borderOnForeground: true,
                elevation: 5.0,
              ),
              new SizedBox(height: 20.0),
              new Text(
                '${iterator.current?.explication}',
                textAlign: TextAlign.center,
              ),
              new SizedBox(height: 20.0),
              new RaisedButton(
                  child: new Text('Au suivant'),
                  color: Colors.blue,
                  onPressed: () => service.next(answer, context))
            ],
          );
        });
  }
}
