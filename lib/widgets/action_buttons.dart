import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: kThemeColor,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {},
            icon: const Icon(Icons.menu_book),
            label: const Text('ابدأ القراءة'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.star_border, color: Colors.white),
          ),
        ),
      ],
    );
  }
}