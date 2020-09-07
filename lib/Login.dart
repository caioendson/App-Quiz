import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Título'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Center(
         child: Text("Primeira linha",
             style: TextStyle(
               color: Colors.red,
               fontSize: 20,
             ),
        ),

        ),
      ),
    );

  }

}