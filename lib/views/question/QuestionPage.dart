import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:question_app/models/Question.dart';

class QuestionPage extends StatefulWidget {
  QuestionPage({Key key}) : super(key: key);

  @override
  _QuestionPageState createState() {
    return _QuestionPageState();
  }
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> questions = <Question>[];
  Iterator<Question> iterator;
  int score = 0;

  @override
  void initState() {
    super.initState();

    questions = <Question>[
      new Question('La devise de la Belgique est l\'union fait la force',
          'belgique', '', true),
      new Question(
          'La lune va finir par tomber sur terre à cause de la gravité',
          'lune',
          'Au contraire la lune s\'éloigne',
          false),
      new Question('La Russie est plus grande en superficie que Pluton',
          'russie', '', true),
      new Question('Nyctalope est une race naine d\'antilope', 'nyctalope',
          'C’est une aptitude à voir dans le noir', false),
      new Question('Le Commodore 64 est l\’oridnateur de bureau le plus vendu',
          'commodore', '', true),
      new Question('Le nom du drapeau des pirates es black skull', 'pirate',
          'Il est appelé Jolly Roger', false, extension: 'png'),
      new Question('Haddock est le nom du chien Tintin', 'tintin',
          'C\'est Milou', false),
      new Question('La barbe des pharaons était fausse', 'pharaon',
          'A l\'époque déjà ils utilisaient des postiches', true),
      new Question(
          'Au Québec tire toi une bûche veut dire viens viens t\'asseoir',
          'buche',
          'La bûche, fameuse chaise de bucheron',
          true),
      new Question(
          'Le module lunaire Eagle de possédait de 4Ko de Ram',
          'eagle',
          'Dire que je me plains avec mes 8GO de ram sur mon mac',
          true)
    ];

    iterator = questions.iterator;
    iterator.moveNext();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Le Quizz'),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new SizedBox(
              height: 20.0,
            ),
            new Text(
                'Question numéro ${questions.indexOf(iterator.current) + 1}'),
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
                  iterator.current.resolveImagePath(),
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
              '${iterator.current.libelle}',
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
                    onPressed: () => this.showResult(true)),
                new RaisedButton(
                    child: new Text('Faux'),
                    color: Colors.blue,
                    onPressed: () => this.showResult(false))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<Null> showResult(bool rep) async {
    bool answer = rep == this.iterator.current.reponse;
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
                  height: MediaQuery.of(ctx).size.height /3.5,
                ),
                borderOnForeground: true,
                elevation: 5.0,
              ),
              new SizedBox(
                height: 20.0
              ),
              new Text('${iterator.current.explication}', textAlign: TextAlign.center,),
              new SizedBox(
                  height: 20.0
              ),
              new RaisedButton(
                  child: new Text('Au suivant'),
                  color: Colors.blue,
                  onPressed: () => this.nextQuestion(answer)
              )
            ],
          );
        });
  }

  void nextQuestion(bool answer) {
    setState(() {
      if (iterator.moveNext()) {
        if (answer) score = score + 1;
      }
      Navigator.of(context).pop();
    });
  }
}

