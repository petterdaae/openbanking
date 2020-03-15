import 'package:firebase_auth/firebase_auth.dart';

class Dependencies {
  const Dependencies({
    this.auth,
    this.email,
    this.password,
  });

  final FirebaseAuth auth;
  final String email;
  final String password;
}
