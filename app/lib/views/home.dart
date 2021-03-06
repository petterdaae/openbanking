import 'package:app/views/all_accounts.dart';
import 'package:app/views/all_transactions.dart';
import 'package:app/views/dev_tools.dart';
import 'package:app/views/drawer_header.dart';
import 'package:app/views/settings.dart';
import 'package:app/views/spending.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import 'categories.dart';

enum Page { Home, Categories, Settings, Dev }

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  Page page = Page.Home;
  bool hideHiddenTransactions = true;

  final List<Widget> _title = [
    Text('🏦 Accounts'),
    Text('💸 Transactions'),
    Text('💳 Spending'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getTitle(),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
            ),
      ),
      drawer: SideNav(navigator: this.navigate),
      body: getBody(),
      backgroundColor: Colors.white,
      floatingActionButton: floatingActionButton(),
      bottomNavigationBar: page == Page.Home
          ? BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
              elevation: 100.0,
              backgroundColor: Colors.white,
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
        return getHomeBody();
      case Page.Categories:
        return Categories();
      case Page.Settings:
        return Settings();
      case Page.Dev:
        return DevTools();
      default:
        return Center(child: Text("Navigation Error"));
    }
  }

  Widget getHomeBody() {
    switch (_currentIndex) {
      case 0:
        return AllAccounts();
      case 1:
        return AllTransactions(
          hideHiddenTransactions: hideHiddenTransactions,
        );
      case 2:
        return Spending();
      default:
        return null;
    }
  }

  Widget getTitle() {
    switch (page) {
      case Page.Home:
        return _title[_currentIndex];
      case Page.Categories:
        return Text("📂 Categories");
      case Page.Settings:
        return Text("⚙️ Settings");
      case Page.Dev:
        return Text("⚒️ Dev");
      default:
        return Text("Navigation Error");
    }
  }

  Widget floatingActionButton() {
    if (page == Page.Home) {
      if (_currentIndex == 1) {
        return FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            setState(() {
                              hideHiddenTransactions = !hideHiddenTransactions;
                            });
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            title: hideHiddenTransactions
                                ? Text("Show hidden transactions")
                                : Text("Hide hidden transactions"),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          },
          child: Icon(CommunityMaterialIcons.filter_variant),
        );
      }
    }
    return null;
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
          MyDrawerHeader(),
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
