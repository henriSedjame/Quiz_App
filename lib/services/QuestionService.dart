
import 'package:flutter/cupertino.dart';
import 'package:question_app/models/Question.dart';

class QuestionService extends ChangeNotifier {
  List<Question> questions;
  Iterator<Question> questionIterator;
  int score = 0;
  bool ended = false;

  QuestionService(){
    this.questions = <Question>[
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

    this.questionIterator = this.questions.iterator;



    this.questionIterator.moveNext();
  }

  void next(bool answer, BuildContext context) {
    if(this.questionIterator.moveNext()) {
      if (answer) this.score++;
    } else {
      this.ended = true;
    }
    notifyListeners();
    Navigator.of(context).pop();
  }

  void reset() {
    score = 0;
    ended = false;
    notifyListeners();
  }
}
