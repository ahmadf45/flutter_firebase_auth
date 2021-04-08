import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/page/signInPage.dart';
import 'package:provider/provider.dart';

class Validator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      // ignore: missing_required_param
      StreamProvider.value(value: FirebaseAuth.instance.authStateChanges())
    ], child: TransactionPage());
  }
}

class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) {
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      });
    } else {
      return Transaction();
    }
    return Center(child: CircularProgressIndicator());
  }
}

class Transaction extends StatefulWidget {
  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return Scaffold(
        body: Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(user.photoURL),
            ),
            Text("Email: " + user.email),
            Text("Nama: " + user.displayName)
          ],
        ),
      ),
    ));
  }
}
