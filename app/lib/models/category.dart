import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category {
  const Category({
    @required this.name,
    @required this.id,
    @required this.icon,
  });

  final String name;
  final String id;
  final String icon;

  static Category parse(DocumentSnapshot snapshot) => Category(
        name: snapshot["name"],
        id: snapshot.documentID,
        icon: snapshot["icon"],
      );

  static Widget getIcon(String name) {
    switch (name) {
      case "netflix":
        return CircleAvatar(
          backgroundImage: AssetImage("assets/netflix.png"),
        );
      case "food":
        return avatarIcon(
          CommunityMaterialIcons.food_apple,
          Colors.green,
          Colors.white,
        );
      case "transport":
        return avatarIcon(
          CommunityMaterialIcons.bus,
          Colors.deepOrange,
          Colors.white,
        );
      default:
        return avatarIcon(
          CommunityMaterialIcons.help,
          Colors.grey,
          Colors.white,
        );
    }
  }

  static Widget avatarIcon(IconData data, Color background, Color icon) {
    return CircleAvatar(
      backgroundColor: background,
      child: Icon(
        data,
        color: icon,
      ),
    );
  }
}
