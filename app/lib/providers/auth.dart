import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dependencies.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
}

class Auth extends ChangeNotifier {
  Auth() {
    _authStatus = AuthStatus.NotAuthenticated;
    _uid = null;
  }

  AuthStatus _authStatus;
  String _uid;

  AuthStatus get authStatus => _authStatus;
  String get uid => _uid;

  void listen(BuildContext context) {
    var deps = Provider.of<Dependencies>(context, listen: false);
    deps.auth.onAuthStateChanged.listen((user) {
      if (user != null &&
          _authStatus != AuthStatus.Authenticated &&
          _authStatus != AuthStatus.Authenticating) {
        _uid = user.uid;
        _authStatus = AuthStatus.Authenticated;
        notifyListeners();
      }
    });
  }

  Future<bool> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    _authStatus = AuthStatus.Authenticating;
    notifyListeners();
    try {
      var deps = Provider.of<Dependencies>(context, listen: false);
      AuthResult authResult = await deps.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _authStatus = AuthStatus.Authenticated;
      _uid = authResult.user.uid;
    } on Exception catch (ex) {
      print(ex);
      _authStatus = AuthStatus.NotAuthenticated;
      notifyListeners();
      return false;
    }
    notifyListeners();
    return true;
  }

  Future<bool> signOut(BuildContext context) async {
    var deps = Provider.of<Dependencies>(context, listen: false);
    try {
      await deps.auth.signOut();
    } on Exception catch (ex) {
      print(ex);
      return false;
    }
    _authStatus = AuthStatus.NotAuthenticated;
    notifyListeners();
    return true;
  }
}
