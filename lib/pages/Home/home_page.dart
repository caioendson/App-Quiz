import 'package:flutter/material.dart';
import 'package:flutter_teste/models/QuestionModel.dart';
import 'package:flutter_teste/pages/Game/game_page.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionModel>(
      builder: (_cntx, questionModel, child) => Scaffold(
        appBar: AppBar(
          leading: SizedBox(),
          centerTitle: true,
          actions: [],
          title: Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(child: Placeholder()),
              FlatButton(
                color: Colors.green,
                textColor: Colors.white,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (cntx) => Game(
                      questions: questionModel.get4Questions(),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('JOGAR')],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
