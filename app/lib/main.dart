import 'package:app/providers/auth.dart';
import 'package:app/providers/dependencies.dart';
import 'package:app/providers/utilities.dart';
import 'package:app/views/login.dart';
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
          backgroundColor: Colors.white,
          primaryColor: Color.fromRGBO(68, 85, 90, 1),
          colorScheme: ColorScheme.light().copyWith(
            secondary: Color.fromRGBO(68, 85, 90, 1),
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
    auth.listen(context);
    switch (auth.authStatus) {
      case AuthStatus.NotAuthenticated:
        return Login();
      case AuthStatus.Authenticating:
        return Authenticating();
      case AuthStatus.Authenticated:
        return Home();
    }
    return null;
  }
}
