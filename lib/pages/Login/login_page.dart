import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_teste/service/RealtimeDBApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  final Function loginFn;
  @override
  _LoginState createState() => _LoginState();

  Login({Key key, this.loginFn}) : super(key: key);
}

class _LoginState extends State<Login> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _emailValidation;
  String _passwordValidation;

  @override
  void initState() {
    _prefs.then((__prefs) => setState(() => this.prefs = __prefs));
    super.initState();
  }

  _emailValidator(String email) {
    if (email == '{}') {
      setState(() {
        _emailValidation = 'Email não cadastrado';
      });
    } else {
      setState(() {
        _emailValidation = null;
      });
    }
  }

  _passwordValidator(String pass) {
    if (pass != passwordController.text.trim()) {
      setState(() {
        _passwordValidation = 'Senha incorreta';
      });
    } else {
      setState(() {
        _passwordValidation = null;
      });
    }
  }

  _login() async {
    var res = await RealtimeDBApi.api.get(
        '/users.json?orderBy="email"&equalTo="${emailController.text.trim()}"');
    _emailValidator(res.data.toString());
    var id = res.data.keys.toList().elementAt(0);
    _passwordValidator((res.data)[id]['password']);
    if (_formKey.currentState.validate()) {
      this.widget.loginFn(
            emailController.text,
            passwordController.text,
            (res.data)[id]['name'],
            context,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
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
                  SizedBox(height: 15),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
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
                            errorStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          validator: (str) => _emailValidation,
                        ),
                        TextFormField(
                          validator: (str) => _passwordValidation,
                          controller: passwordController,
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
                            errorStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: _login,
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ENTRAR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
