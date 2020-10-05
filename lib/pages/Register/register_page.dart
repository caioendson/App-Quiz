import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teste/pages/Login/login_page.dart';
import 'package:flutter_teste/service/RealtimeDBApi.dart';

class Register extends StatefulWidget {
  final Function loginFn;
  @override
  _RegisterState createState() => _RegisterState();

  Register({Key key, this.loginFn}) : super(key: key);
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  _registerPressed(context) async {
    if (_formKey.currentState.validate()) {
      var res = await RealtimeDBApi.api.get(
          '/users.json?orderBy="email"&equalTo="${emailController.text.trim()}"');
      if (res.data.toString() != '{}') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Email já cadastrado',
              style: TextStyle(color: Colors.red[100]),
            ),
          ),
        );
      } else {
        FirebaseDatabase.instance.reference().child('users').push().set({
          'name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }).whenComplete(
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_cntx) => Login(loginFn: this.widget.loginFn),
            ),
          ),
        );
      }
    }
  }

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
          padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration:
                            InputDecoration(hintText: 'Nome de usuário'),
                        validator: (str) =>
                            str.isEmpty ? 'O nome não pode ser vazio' : null,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(hintText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (str) {
                          final RegExp emailRegex = new RegExp(
                            r'\w*@\w*.\w*',
                            caseSensitive: false,
                          );
                          return emailRegex.hasMatch(str)
                              ? null
                              : 'Email inválido';
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(hintText: 'Senha'),
                        validator: (str) =>
                            str.isEmpty ? 'A senha não pode ser vazia' : null,
                      ),
                    ],
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () => _registerPressed(context),
                color: Colors.green,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
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
