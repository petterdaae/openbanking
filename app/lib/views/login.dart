import 'package:app/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Auth auth = Provider.of<Auth>(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(32)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Password",
              ),
            ),
          ),
          OutlineButton(
            onPressed: () => auth.login(
              context,
              emailController.text,
              passwordController.text,
            ),
            child: Text("Login"),
          ),
        ],
      ),
    );
  }
}

class Authenticating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Loading"),
        ),
      ),
    );
  }
}
