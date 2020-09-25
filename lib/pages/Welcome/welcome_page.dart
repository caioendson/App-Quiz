import 'package:flutter/material.dart';
import 'package:flutter_teste/pages/Login/login_page.dart';
import 'package:flutter_teste/pages/Register/register_page.dart';

class Welcome extends StatelessWidget {
  final Function loginFn;
  Welcome({Key key, this.loginFn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 90),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset('assets/images/logo.png', height: 150),
              ),
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (cntx) => Login(
                            loginFn: loginFn,
                          ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ENTRAR',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              color: Colors.green,
              textColor: Colors.white,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (cntx) => Register(
                            loginFn: loginFn,
                          ))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'CADASTRE-SE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              color: Colors.orange,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
