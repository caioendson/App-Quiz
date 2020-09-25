import 'package:flutter/material.dart';
import 'package:flutter_teste/pages/Login/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  final Function loginFn;
  @override
  _RegisterState createState() => _RegisterState();

  Register({Key key, this.loginFn}) : super(key: key);
}

class _RegisterState extends State<Register> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  _registerPressed() async {
    final prefs = await _prefs;
    if (_formKey.currentState.validate()) {
      await prefs.setString('EducaIoT:email', emailController.text.trim());
      await prefs.setString(
          'EducaIoT:password', passwordController.text.trim());
      await prefs.setString('EducaIoT:name', nameController.text.trim());
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_cntx) => Login(loginFn: this.widget.loginFn),
        ),
      );
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
                        validator: (str) {
                          final RegExp emailRegex = new RegExp(
                            r'\w*@\w*.com',
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
                onPressed: _registerPressed,
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
