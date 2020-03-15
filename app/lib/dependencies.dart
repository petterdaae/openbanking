import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dependencies {
  const Dependencies({
    this.auth,
    this.firestore,
    this.email,
    this.password,
  });

  final FirebaseAuth auth;
  final Firestore firestore;
  final String email;
  final String password;
}
