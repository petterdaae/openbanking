import 'package:app/views/all_accounts.dart';
import 'package:app/views/all_transactions.dart';
import 'package:app/views/dev_tools.dart';
import 'package:app/views/spending.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

enum Page { Home, Categories, Settings, Dev }

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Page page = Page.Home;

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
      drawer: SideNav(navigator: this.navigate),
      body: getBody(),
      bottomNavigationBar: page == Page.Home
          ? BottomNavigationBar(
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
            )
          : null,
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget getBody() {
    switch (page) {
      case Page.Home:
        return _children[_currentIndex];
      case Page.Categories:
        return Text("Categories");
      case Page.Settings:
        return Text("Settings");
      case Page.Dev:
        return Text("Dev");
      default:
        return Text("Navigation Error");
    }
  }

  void navigate(Page newPage) {
    setState(() {
      page = newPage;
    });
  }
}

class SideNav extends StatelessWidget {
  const SideNav({@required this.navigator});

  final Function(Page) navigator;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Open Banking',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
              title: Text('Home'), onTap: () => navigate(context, Page.Home)),
          ListTile(
              title: Text('Categories'),
              onTap: () => navigate(context, Page.Categories)),
          ListTile(
              title: Text('Settings'),
              onTap: () => navigate(context, Page.Settings)),
          ListTile(
              title: Text('Dev'), onTap: () => navigate(context, Page.Dev)),
        ],
      ),
    );
  }

  void navigate(BuildContext context, Page newPage) {
    Navigator.of(context).pop();
    this.navigator(newPage);
  }
}
