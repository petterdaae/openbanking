import 'package:app/auth.dart';
import 'package:app/dependencies.dart';
import 'package:app/views/all_accounts.dart';
import 'package:app/views/all_transactions.dart';
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
                  'Login',
                ),
              )
            : Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    AllAccountsWidget(),
    AllTransactionsWidget(),
  ];
  final List<Widget> _title = [
    Text('Accounts'),
    Text('Transactions'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title[_currentIndex],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.email),
            title: Text('Accounts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.enhanced_encryption),
            title: Text('Transactions'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
