import 'package:app/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Center(
      child: OutlineButton(
        onPressed: () {
          auth.signOut(context);
        },
        child: Text("Sign out"),
      ),
    );
  }
}
