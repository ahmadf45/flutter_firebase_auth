import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/authService.dart';
import 'package:flutter_firebase_auth/page/tabs.dart';
import 'package:provider/provider.dart';
import '../authService.dart';

class Validator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // ignore: missing_required_param
      StreamProvider.value(value: FirebaseAuth.instance.authStateChanges())
    ], child: SignInPage());
  }
}

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user != null) {
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Tabs()));
      });
    } else {
      return SignIn();
    }
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool vemail = false;
  bool vpassword = false;

  var temail = TextEditingController();
  var tpassword = TextEditingController();

  bool isLoading = false;

  Future<SnackBar> signIn() async {
    await AuthService()
        .signIn(email: temail.text, password: tpassword.text)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(value));
    //print(temail.text);
  }

  Future<String> loginGoogle() async {
    isLoading = true;
    await AuthService().signInGoogle().then((value) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("data :" + value))));
    isLoading = true;
  }

  Future<String> loginFacebook() async {
    await AuthService().signInFacebook().then((value) =>
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("data :" + value))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tambah Data',
                style: TextStyle(color: Colors.black, fontSize: 22)),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: temail,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: tpassword,
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            ElevatedButton(onPressed: () => {signIn()}, child: Text("GO")),
            ElevatedButton(
                onPressed: () => {loginGoogle()}, child: Text("Login Google")),
            ElevatedButton(
                onPressed: () => {loginFacebook()},
                child: Text("Login Facebook"))
          ],
        ),
      ),
    );
  }
}
