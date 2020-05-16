import 'package:app/components/avatar_icons_list.dart';
import 'package:flutter/material.dart';

class PickIcon extends StatelessWidget {
  const PickIcon({
    this.onIconTapped,
  });

  final Function(String) onIconTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AvatarIconsListComponent(
        onIconTapped: onIconTapped,
      ),
    );
  }
}
