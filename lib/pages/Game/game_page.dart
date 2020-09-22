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
      backgroundColor: Theme.of(context).backgroundColor,
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        controller: _controllerPageView,
        itemBuilder: (cntx, inx) => Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Container(
                color: Colors.grey[800],
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                child: Text(
                  ' O que signifca Things na internet das coisas? ' * (inx + 1),
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
                  children: [1, 2, 3]
                      .map((e) => FlatButton(
                            color: Colors.white,
                            onPressed: () {
                              _controllerPageView.nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.ease);
                            },
                            child: Row(
                              children: [
                                Text('Responder'),
                              ],
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
