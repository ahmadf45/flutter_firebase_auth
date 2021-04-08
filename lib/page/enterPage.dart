import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/authService.dart';
import 'package:flutter_firebase_auth/page/signInPage.dart';
import 'package:flutter_firebase_auth/page/tabs.dart';
import 'package:provider/provider.dart';

class Validator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // ignore: missing_required_param
      StreamProvider.value(value: FirebaseAuth.instance.authStateChanges())
    ], child: EnterPage());
  }
}

class EnterPage extends StatelessWidget {
  logout(context) async {
    await AuthService().logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Tabs()));
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      });
    } else {
      return Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              logout(context);
            },
            child: Text("Logout"),
          ),
        ),
      );
    }
    return CircularProgressIndicator();
  }
}
