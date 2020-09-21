import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: 'Nome de usuário'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      decoration: InputDecoration(hintText: 'Senha'),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.green,
                textColor: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CADASTRAR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
