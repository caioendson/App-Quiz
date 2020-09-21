import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  final PageController _controllerPageView = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        controller: _controllerPageView,
        itemBuilder: (cntx, inx) => Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pergunta $inx'),
              FlatButton(
                onPressed: () {
                  _controllerPageView.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Text('Responder'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
