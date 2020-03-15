import 'package:app/auth.dart';
import 'package:app/dependencies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dependencies>(
          create: (_) => Dependencies(
            auth: FirebaseAuth.instance,
            firestore: Firestore.instance,
            email: 'petter.daae@gmail.com',
            password: 'Zl88d^Zy54ph96FE1Zy!n',
          ),
        ),
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(home: App()),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context);
    return Scaffold(
      body: Center(
        child: !auth.authenticated
            ? FlatButton(
                onPressed: () {
                  auth.login(context);
                },
                child: Text(
                  'Not authenticated',
                ),
              )
            : Text('Authenticated as ' + auth.uid),
      ),
    );
  }
}
