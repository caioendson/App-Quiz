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
  final PageController _controllerPageView = new PageController();

  @override
  void initState() {
    this.timeInit = DateTime.now();
    this.timeToRecord = DateTime.now();
    super.initState();
  }

  List<String> randomAnswers(int inx) {
    var question = super.widget.questions.elementAt(inx);
    var wrongs = question.wrongAnswers.toList();
    wrongs.insert(rnd.nextInt(wrongs.length + 1), question.correctAnswer);
    return wrongs;
  }

  void _onPressed(String correctAnswer, String pressedAnswer) {
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
    _controllerPageView.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.ease);
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
                        textScaleFactor: 2,
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
                          children: randomAnswers(inx)
                              .map((btnText) => Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(top: 10),
                                    padding: EdgeInsets.all(15),
                                    child: FlatButton(
                                      onPressed: () => _onPressed(
                                        super
                                            .widget
                                            .questions
                                            .elementAt(inx)
                                            .correctAnswer,
                                        btnText,
                                      ),
                                      child: Text(
                                        btnText,
                                        style: TextStyle(),
                                      ),
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
