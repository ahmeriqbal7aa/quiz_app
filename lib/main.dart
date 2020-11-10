import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'quiz_store.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//we made global variable of QuizStore bcz we can access it in main anywhere like classes, functions, expanded widgets etc
QuizStore quizStore = QuizStore();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purpleAccent.shade700,
          title: Text(
            'Quiz App',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
          //TODO background image container
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/Pic.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int right = 0;
  int wrong = 0;
  int score = 0;
  //we create list of icon bcz we don't create multiple Icons widgets for every questions
  List<Icon> scoreKeeper = [];

  //TODO here we made function that check answer is either true or false
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizStore.getCorrectAnswer();
    setState(() {
      if (quizStore.isFinished() == true) {
        //TODO below if else will check last question when it return then display alert message
        if (userPickedAnswer == correctAnswer) {
          right++;
          score += 10; //assignment addition operator use
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          wrong++;
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        //we write context because we run it in this same class
        Alert(
          context: context,
          title: 'Quiz Finished',
          desc: 'Correct is: $right | Wrong is: $wrong\nScore is: $score/130',
        ).show();
        quizStore.reset();
        scoreKeeper = [];
        right = 0;
        wrong = 0;
        score = 0;
      } else {
        if (userPickedAnswer == correctAnswer) {
          right++;
          score += 10; //assignment addition operator use
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          wrong++;
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
        quizStore.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //TODO total questions and marks
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total questions are 13 ... Each has 10 marks',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        //TODO right and wrong
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Right: $right',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.greenAccent.shade700,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Wrong: $wrong',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
        //TODO get text
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizStore.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        //TODO true and false button
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: FlatButton(
                  color: Colors.purpleAccent.shade700,
                  splashColor: Colors.greenAccent.shade700,
                  child: Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(true);
                    //The user picked true.
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: FlatButton(
                  color: Colors.purpleAccent.shade700,
                  splashColor: Colors.redAccent.shade700,
                  child: Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(false);
                    //The user picked false.
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
