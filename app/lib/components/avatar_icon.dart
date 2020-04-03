import 'package:app/models/category.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class AvatarIconComponent extends StatelessWidget {
  const AvatarIconComponent({
    this.name,
    this.category,
    this.size = 20,
  });

  final String name;
  final Category category;
  final double size;

  @override
  Widget build(BuildContext context) {
    String _name = name;
    if (category != null) _name = category.icon;
    switch (_name) {
      case "netflix":
        return _avatarImage("assets/netflix.png");
      case "food":
        return _avatarIcon(
          CommunityMaterialIcons.food_apple,
          Colors.green,
          Colors.white,
          context,
        );
      case "transport":
        return _avatarIcon(
          CommunityMaterialIcons.bus,
          Colors.deepOrange,
          Colors.white,
          context,
        );
      default:
        return _avatarIcon(
          CommunityMaterialIcons.help,
          Colors.grey,
          Colors.white,
          context,
        );
    }
  }

  Widget _avatarIcon(
      IconData data, Color background, Color icon, BuildContext context) {
    return CircleAvatar(
      backgroundColor: background,
      radius: size,
      child: Icon(
        data,
        color: icon,
        size: size,
      ),
    );
  }

  Widget _avatarImage(String path) {
    return CircleAvatar(
      radius: size,
      backgroundImage: AssetImage("assets/netflix.png"),
    );
  }
}
