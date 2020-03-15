import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dependencies.dart';

class Auth extends ChangeNotifier {
  Auth() {
    _authenticated = false;
    _uid = null;
  }

  bool _authenticated;
  String _uid;

  bool get authenticated => _authenticated;
  String get uid => _uid;

  Future<bool> login(BuildContext context) async {
    try {
      var deps = Provider.of<Dependencies>(context, listen: false);
      AuthResult authResult = await deps.auth.signInWithEmailAndPassword(
        email: deps.email,
        password: deps.password,
      );
      _authenticated = true;
      _uid = authResult.user.uid;
    } on Exception catch (ex) {
      print(ex);
      return false;
    }
    notifyListeners();
    return true;
  }
}
