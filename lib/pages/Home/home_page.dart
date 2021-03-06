import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teste/models/QuestionModel.dart';
import 'package:flutter_teste/pages/Game/game_page.dart';
import 'package:flutter_teste/service/RealtimeDBApi.dart';
import 'package:flutter_teste/utils/EducaIoTKeys.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final Function exitFn;

  Home({Key key, this.exitFn}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  String userName;
  List<Question> _questions;

  _randomize4Questions() {
    Random random = new Random();
    List<Question> randomizedQuestions = [];

    for (var inx = 0; inx < 4;) {
      var randomInt = random.nextInt(this._questions.length);
      if (!randomizedQuestions.contains(this._questions.elementAt(randomInt))) {
        randomizedQuestions.add(this._questions.elementAt(randomInt));
        inx++;
      }
    }
    return randomizedQuestions;
  }

  _initQuestions() async {
    try {
      var res = await RealtimeDBApi.api.get('/questions.json');
      var _keys = res.data.keys;
      List<Question> questions = [];
      for (var id in _keys) {
        List<String> wrongs = [];
        for (var wrong in res.data[id]['wrongsAnswers']) {
          wrongs.add(wrong);
        }
        Question question = new Question(
          res.data[id]['title'],
          res.data[id]['correctAnswer'],
          wrongs,
        );
        questions.add(question);
      }
      setState(() {
        _questions = questions;
      });
      List<String> questionToStorage = [];
      for (var q in questions) {
        questionToStorage.add(q.toString());
      }
      var pref = await _pref;
      pref.setStringList(EducaIoT.questions, questionToStorage);
    } catch (err) {
      List<Question> questions = [];
      var pref = await _pref;
      for (var quest in pref.getStringList(EducaIoT.questions)) {
        questions.add(Question.parse(quest));
      }
      setState(() {
        _questions = questions;
      });
    }
  }

  @override
  void initState() {
    _pref.then((prefs) {
      setState(() {
        userName = prefs.getString(EducaIoT.name);
      });
    });
    _initQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionModel>(
      builder: (_cntx, questionModel, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          leading: SizedBox(),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => widget.exitFn(),
            ),
          ],
          title: Image.asset('assets/images/logo.png', height: 50),
        ),
        body: Container(
          padding: EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Olá $userName, torne-se um expert em IoT.',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cntx) => Game(
                      questions: _randomize4Questions(),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Text(
                        'JOGAR',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
