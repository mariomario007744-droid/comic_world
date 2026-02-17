import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const MenuItem({super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: kTextColor),
      title: Text(text, style: TextStyle(color: kTextColor)),
      onTap: onTap,
    );
  }
}