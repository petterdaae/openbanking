import 'package:app/components/avatar_icon.dart';
import 'package:app/views/pick_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewCategory extends StatefulWidget {
  @override
  _NewCategoryState createState() => _NewCategoryState();
}

class _NewCategoryState extends State<NewCategory> {
  String _iconName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New category"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => PickIcon(
                      onIconTapped: (icon) {
                        setState(() {
                          _iconName = icon;
                        });
                      },
                    ),
                  ),
                );
              },
              child: AvatarIconComponent(name: _iconName, size: 50),
            ),
            Padding(padding: EdgeInsets.all(8)),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Category name"),
            ),
            Padding(padding: EdgeInsets.all(8)),
            OutlineButton(
              child: Text("Create"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
