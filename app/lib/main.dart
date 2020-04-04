import 'package:app/auth.dart';
import 'package:app/dependencies.dart';
import 'package:app/utilities.dart';
import 'package:app/views/all_accounts.dart';
import 'package:app/views/all_transactions.dart';
import 'package:app/views/category_list.dart';
import 'package:app/views/dev_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:community_material_icon/community_material_icon.dart';
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
        theme: ThemeData.light().copyWith(),
      ),
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
    AllAccounts(),
    AllTransactions(),
    CategoryList(),
    DevTools(),
  ];

  final List<Widget> _title = [
    Text('Accounts'),
    Text('Transactions'),
    Text('Categories'),
    Text('Developer tools'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title[_currentIndex],
      ),
      body: _children[_currentIndex],
      floatingActionButton: floatingActionButton(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(CommunityMaterialIcons.bank),
            title: Text('Accounts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CommunityMaterialIcons.cash_multiple),
            title: Text('Transactions'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CommunityMaterialIcons.shape),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CommunityMaterialIcons.laptop),
            title: Text('Dev'),
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

  Widget floatingActionButton() {
    if (_currentIndex == 1) {
      return FloatingActionButton(
        child: Icon(CommunityMaterialIcons.tune_vertical),
        onPressed: () {
          Scaffold.of(context).showBottomSheet(
            (context) => Filters(),
          );
        },
      );
    }
    return null;
  }
}

class Filters extends StatelessWidget {
  const Filters({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
        ),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 32)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8)),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
            child: Text(
              "General",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
            child: Wrap(
              spacing: 8,
              children: [
                FilterChip(label: Text("Don't show hidden transactions"))
              ],
            ),
          ),
          Divider(
            indent: 8,
            endIndent: 8,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
            child: Text(
              "Accounts",
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
            child: Wrap(
              spacing: 8,
              children: <Widget>[
                FilterChip(label: Text("Kort")),
                FilterChip(label: Text("Spare")),
                FilterChip(label: Text("BSU")),
                FilterChip(label: Text("Studielån")),
                FilterChip(label: Text("Utgifter")),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(8)),
        ],
      ),
    );
  }
}
