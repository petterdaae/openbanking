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
      case "hobbies":
        return _avatarIcon(
          CommunityMaterialIcons.baseball_bat,
          Colors.lightBlue,
          Colors.white,
          context,
        );
      case "servicessoftware":
        return _avatarIcon(
          CommunityMaterialIcons.earth,
          Colors.black,
          Colors.white,
          context,
        );
      case "alcohol":
        return _avatarIcon(
          CommunityMaterialIcons.glass_mug,
          Colors.purple,
          Colors.white,
          context,
        );
      case "hide":
        return _avatarIcon(
          CommunityMaterialIcons.eye_off,
          Colors.grey,
          Colors.white,
          context,
        );
      case "income":
        return _avatarIcon(
          CommunityMaterialIcons.cash_usd,
          Colors.yellow,
          Colors.black,
          context,
        );
      case "house":
        return _avatarIcon(
          CommunityMaterialIcons.home,
          Colors.red,
          Colors.white,
          context,
        );
      case "tool":
        return _avatarIcon(
          CommunityMaterialIcons.toolbox,
          Colors.pink,
          Colors.white,
          context,
        );
      case "foodanddrinks":
        return _avatarIcon(
          CommunityMaterialIcons.food_fork_drink,
          Colors.purple,
          Colors.white,
          context,
        );
      case "school":
        return _avatarIcon(
          CommunityMaterialIcons.school,
          Colors.blue,
          Colors.white,
          context,
        );
      case "sbanken":
        return _avatarImage("assets/sbanken.png");
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
    IconData data,
    Color background,
    Color icon,
    BuildContext context,
  ) {
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
      backgroundImage: AssetImage(path),
    );
  }

  static List<AvatarIconComponent> allIcons() {
    return [
      "netflix",
      "food",
      "transport",
      "hobbies",
      "servicessoftware",
      "alcohol",
      "hide",
      "income",
      "sbanken",
      "house",
      "tool",
      "foodanddrinks",
      "school",
    ]
        .map((name) => AvatarIconComponent(
              name: name,
              size: 50,
            ))
        .toList();
  }
}
