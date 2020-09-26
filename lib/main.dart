import 'package:flutter/material.dart';
import 'package:flutter_teste/models/QuestionModel.dart';
import 'package:flutter_teste/pages/Home/home_page.dart';
import 'package:flutter_teste/pages/Welcome/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz IoT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: Colors.blue,
        backgroundColor: Colors.blue[400],
      ),
      home: ChangeNotifierProvider(
        create: (cntx) => QuestionModel(),
        child: MyHomePage(title: 'Educa IoT'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool isLoged;

  @override
  void initState() {
    super.initState();
    _prefs.then((prefs) {
      setState(() => isLoged = prefs.getBool('EducaIoT:isLoged') ?? false);
    });
  }

  _exitFn() async {
    final prefs = await _prefs;
    prefs.setBool('EducaIoT:isLoged', false);
    setState(() => isLoged = false);
  }

  _loginFn(String email, String password, BuildContext cnt) async {
    final prefs = await _prefs;
    final storagedEmail = prefs.getString('EducaIoT:email');
    final storagedPassword = prefs.getString('EducaIoT:password');
    print('$storagedEmail   $storagedPassword');
    if (storagedEmail == email.trim() && storagedPassword == password.trim()) {
      setState(() => isLoged = true);
      prefs.setBool('EducaIoT:isLoged', true);
      Navigator.pop(cnt);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: isLoged == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isLoged
              ? Home(exitFn: _exitFn)
              : Welcome(loginFn: _loginFn),
    );
  }
}
