import 'package:flutter/material.dart';
import 'package:flutter_teste/pages/Register/register_page.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediaQuery.of(context).viewInsets.bottom == 0
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Text(
                              'Bem-vindo ao',
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Image.asset('assets/images/logo.png', height: 100),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 50),
                  Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                          ),
                          hintText: 'Email',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          hintText: 'Senha',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        onPressed: () {},
                        color: Colors.green,
                        textColor: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'INICIAR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {},
                        child: Row(
                          children: [Text('esqueceu sua senha?')],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (cnt) => Register())),
              child: Row(
                children: [Text('Não possui uma conta? Crie uma.')],
              ),
            )
          ],
        ),
      ),
    );
  }
}
