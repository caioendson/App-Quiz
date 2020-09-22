import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_teste/models/QuestionModel.dart';

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
  final PageController _controllerPageView = new PageController();

  @override
  void initState() {
    super.initState();
  }

  List<String> randomAnswers(int inx) {
    var question = super.widget.questions.elementAt(inx);
    var wrongs = question.wrongAnswers.toList();
    wrongs.insert(rnd.nextInt(wrongs.length + 1), question.correctAnswer);
    return wrongs;
  }

  void _onPressed(String correctAnswer, String pressedAnswer) {
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
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Respostas corretas')),
                          Text('$correctAnswersCount'),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Respostas incorretas')),
                          Text('$wrongAnswersCount'),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Tempo gasto da jogada')),
                          Text('4'),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(10),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text('Melhor tempo de uma jogada')),
                          Text('4'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
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
                        textWidthBasis: TextWidthBasis.parent,
                        textScaleFactor: 2,
                        style: TextStyle(
                          backgroundColor: Colors.grey[800],
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(40),
                      child: Column(
                        children: randomAnswers(inx)
                            .map((e) => Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: FlatButton(
                                    color: Colors.white,
                                    onPressed: () => _onPressed(
                                      super
                                          .widget
                                          .questions
                                          .elementAt(inx)
                                          .correctAnswer,
                                      e,
                                    ),
                                    child: Text(e),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
