import 'package:comic_world/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class MenuSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MenuItem(icon: Icons.favorite, text: 'المفضلة'),
          MenuItem(icon: Icons.category, text: 'التصنيفات'),
          MenuItem(icon: Icons.history, text: 'آخر المشاهدة'),
          MenuItem(icon: Icons.settings, text: 'الإعدادات'),
        ],
      ),
    );
  }
}