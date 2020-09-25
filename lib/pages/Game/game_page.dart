import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_teste/models/QuestionModel.dart';
import 'package:flutter_teste/pages/Game/result_widget.dart';

class Game extends StatefulWidget {
  final List<Question> questions;

  @override
  _GameState createState() => _GameState();

  Game({Key key, this.questions}) : super(key: key);
}

class _GameState extends State<Game> {
  final Random rnd = new Random();
  int correctAnswersCount = 0;
  int wrongAnswersCount = 0;
  DateTime timeInit;
  DateTime timeToRecord;
  Duration record;
  String _pressedAnswer;
  String _correctAnswer;
  List<List<String>> _randomizedAnswers = [];
  bool _blockActions = false;
  final PageController _controllerPageView = new PageController();

  @override
  void initState() {
    randomAnswers();
    this.timeInit = DateTime.now();
    this.timeToRecord = DateTime.now();
    super.initState();
  }

  void randomAnswers() {
    for (var question in super.widget.questions) {
      var wrongs = question.wrongAnswers.toList();
      wrongs.insert(rnd.nextInt(wrongs.length + 1), question.correctAnswer);
      this._randomizedAnswers.add(wrongs);
    }
  }

  Color _colorizeButton(String str) {
    if (str == _correctAnswer)
      return Colors.green[200];
    else if (_pressedAnswer == str) return Colors.red[200];
    return Colors.white;
  }

  void _onPressed(String correctAnswer, String pressedAnswer) {
    if (_blockActions) return null;

    setState(() {
      _correctAnswer = correctAnswer;
      _pressedAnswer = pressedAnswer;
      _blockActions = true;
    });
    Duration _record = DateTime.now().difference(this.timeToRecord);
    if (this.record == null || this.record > _record) {
      setState(() => this.record = _record);
    }
    setState(() => this.timeToRecord = DateTime.now());
    if (correctAnswer == pressedAnswer) {
      setState(() => correctAnswersCount += 1);
    } else {
      setState(() => wrongAnswersCount += 1);
    }
    Timer(Duration(seconds: 2), () {
      _controllerPageView.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
      setState(() {
        _pressedAnswer = null;
        _blockActions = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: super.widget.questions.length + 1,
        controller: _controllerPageView,
        itemBuilder: (cntx, inx) => inx == super.widget.questions.length
            ? Container(
                padding: EdgeInsets.only(top: 50),
                child: Result(
                  correctAnswersCount: this.correctAnswersCount,
                  wrongAnswersCount: this.wrongAnswersCount,
                  elapsedTime: DateTime.now().difference(timeInit),
                  recordTime: record,
                ))
            : Container(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey[800],
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(20),
                      child: Text(
                        super.widget.questions.elementAt(inx).title,
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          backgroundColor: Colors.grey[800],
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _randomizedAnswers
                              .elementAt(inx)
                              .map((btnText) => Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: FlatButton(
                                      onPressed: () => _onPressed(
                                        super
                                            .widget
                                            .questions
                                            .elementAt(inx)
                                            .correctAnswer,
                                        btnText,
                                      ),
                                      color: _colorizeButton(btnText),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 20,
                                        horizontal: 10,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Text(btnText, style: TextStyle()),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
