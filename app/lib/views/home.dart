import 'package:app/views/all_accounts.dart';
import 'package:app/views/all_transactions.dart';
import 'package:app/views/dev_tools.dart';
import 'package:app/views/spending.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    AllAccounts(),
    AllTransactions(),
    Spending(),
    DevTools(),
  ];
  final List<Widget> _title = [
    Text('Accounts'),
    Text('Transactions'),
    Text('Spending'),
    Text('Developer tools'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title[_currentIndex],
      ),
      body: _children[_currentIndex],
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
            title: Text('Spending'),
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
}
