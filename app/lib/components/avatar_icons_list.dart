import 'package:flutter/material.dart';

import 'avatar_icon.dart';

class AvatarIconsListComponent extends StatelessWidget {
  const AvatarIconsListComponent({
    this.onIconTapped,
  });

  final Function(String) onIconTapped;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: AvatarIconComponent.allIcons()
          .map((e) => Padding(
              padding: EdgeInsets.all(8),
              child: InkWell(
                onTap: () {
                  onIconTapped(e.name);
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: e,
                ),
              )))
          .toList(),
    );
  }
}
