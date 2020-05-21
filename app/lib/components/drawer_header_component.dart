import 'package:app/components/avatar_icon.dart';
import 'package:app/models/user.dart';
import 'package:flutter/material.dart';

class DrawerHeaderComponent extends StatelessWidget {
  const DrawerHeaderComponent({
    @required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AvatarIconComponent(
            size: 40,
            name: "profile",
          ),
          Padding(padding: EdgeInsets.all(8)),
          Text(
            user.name,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
