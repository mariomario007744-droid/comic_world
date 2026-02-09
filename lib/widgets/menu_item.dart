import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const MenuItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kThemeColor),
      title: Text(text, style: TextStyle(color: kTextColor)),
      onTap: () {},
    );
  }
}