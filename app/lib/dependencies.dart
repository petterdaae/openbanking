import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Dependencies {
  const Dependencies({
    this.auth,
    this.firestore,
    this.email,
    this.password,
    this.cloudFunctions,
  });

  final FirebaseAuth auth;
  final Firestore firestore;
  final CloudFunctions cloudFunctions;
  final String email;
  final String password;
}
