import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int correctAnswersCount;
  final int wrongAnswersCount;
  final Duration elapsedTime;
  final Duration recordTime;
  Result({
    Key key,
    this.correctAnswersCount,
    this.wrongAnswersCount,
    this.elapsedTime,
    this.recordTime,
  }) : super(key: key);

  List<List<String>> get _data => [
        ['Respostas corretas', '$correctAnswersCount'],
        ['Respostas incorretas', '$wrongAnswersCount'],
        [
          'Tempo gasto da jogada',
          '${elapsedTime.inSeconds ~/ 60}m ${elapsedTime.inSeconds % 60}s'
        ],
        [
          'Melhor tempo de uma jogada',
          '${recordTime.inSeconds ~/ 60}m ${recordTime.inSeconds % 60}s'
        ],
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _data
                .map(
                  (arr) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            arr.elementAt(0),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Text(
                          arr.elementAt(1),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: FlatButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FINALIZAR',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
