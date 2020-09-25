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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
                      controller: nameController,
                      decoration: InputDecoration(hintText: 'Nome de usuário'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(hintText: 'Email'),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(hintText: 'Senha'),
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  final prefs = await _prefs;
                  await prefs.setString('EducaIot:email', emailController.text);
                  await prefs.setString(
                      'EducaIot:password', passwordController.text);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_cntx) =>
                              Login(loginFn: this.widget.loginFn)));
                },
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
