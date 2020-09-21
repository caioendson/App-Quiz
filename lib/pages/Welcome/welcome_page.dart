import 'package:flutter/material.dart';
import 'package:flutter_teste/pages/Login/login_page.dart';
import 'package:flutter_teste/pages/Register/register_page.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
              ),
            ),
            RaisedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (cntx) => Login())),
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
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (cntx) => Register())),
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
