import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:app/providers/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/home.dart';

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
            cloudFunctions: CloudFunctions.instance,
            email: 'petter.daae@gmail.com',
            password: 'Zl88d^Zy54ph96FE1Zy!n',
            utilities: Utilities(),
          ),
        ),
        ChangeNotifierProvider<Auth>(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        home: App(),
        theme: ThemeData.light().copyWith(
          primaryColor: Color.fromRGBO(34, 40, 49, 1),
          colorScheme: ColorScheme.light().copyWith(
            secondary: Color.fromRGBO(242, 163, 101, 1),
            onSecondary: Colors.white,
          ),
        ),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return !auth.authenticated
        ? Scaffold(
            body: Center(
              child: FlatButton(
                onPressed: () {
                  auth.login(context);
                },
                child: Text(
                  'Login',
                ),
              ),
            ),
          )
        : Home();
  }
}
