import 'package:flutter/material.dart';
import 'package:question_app/views/question/QuestionPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Quiz vrai ou faux')),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Card(
              child: Container(
                child: new Image.asset(
                  'assets/images/cover.jpg',
                  fit: BoxFit.cover,
                ),
                width: MediaQuery.of(context).size.height / 2.3,
                height: MediaQuery.of(context).size.height / 2.3,
              ),
              borderOnForeground: true,
              elevation: 15.0,
            ),
            new SizedBox(
              height: 60.0,
            ),
            new RaisedButton(
              child: new Text(
                'Commencer le quizz',
                textScaleFactor: 1.2,
                style: new TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: navigateToQuestionPage,
            )
          ],
        ),
      ),
    );
  }

  void navigateToQuestionPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (BuildContext ctx) {
        return new QuestionPage();
      })
    );
  }
}
