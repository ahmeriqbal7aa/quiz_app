import 'package:flutter/cupertino.dart';

import 'question.dart';
import 'package:quiz_app/question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizStore {
  int _questionNumber = 0;

  //list of questions and index start from 0 to 12 (total 13 question)
  List<Question> _questionStore = [
    Question('1: Some cats are actually allergic to humans', true),
    Question('2: You can lead a cow down stairs but not up stairs.', false),
    Question(
        '3: Approximately one quarter of human bones are in the feet.', true),
    Question('4: A slug\'s blood is green.', true),
    Question('5: Buzz Aldrin\'s mother\'s maiden name was \"Moon\".', true),
    Question('6: It is illegal to pee in the Ocean in Portugal.', true),
    Question(
        '7: No piece of square dry paper can be folded in half more than 7 times.',
        false),
    Question(
        '8: In London(UK) if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.',
        true),
    Question(
        '9: The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.',
        false),
    Question(
        '10: The total surface area of two human lungs is approximately 70 square metres.',
        true),
    Question('11: Google was originally called \"Backrub\".', true),
    Question(
        '12: Chocolate affects a dog\'s heart and nervous system; A few ounces are enough to kill a small dog.',
        true),
    Question(
        '13: In West Virginia(USA) if you accidentally hit an animal with your car, you are free to take it home to eat.',
        true),
  ];

  //below is self created function

  //which is the next question
  void nextQuestion() {
    if (_questionNumber < _questionStore.length - 1) {
      _questionNumber++; //here the next question will come up
    }
  }

  //get the text of question
  String getQuestionText() {
    //here "_questionNumber" mean index of that quextion bcz written in "[]"
    return _questionStore[_questionNumber].questionText;
  }

  //get the answer of question
  bool getCorrectAnswer() {
    //here "_questionNumber" mean index of that quextion bcz written in "[]"
    return _questionStore[_questionNumber].questionAnswer;
  }

  //when questions are finished
  bool isFinished() {
    if (_questionNumber >= _questionStore.length - 1) {
      return true;
    }
  }

  //if this will reset to zero then bool return false
  void reset() {
    _questionNumber = 0;
  }
}
