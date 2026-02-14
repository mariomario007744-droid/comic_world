import 'package:comic_world/const.dart';
import 'package:comic_world/widgets/star_rating.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.comicId});
  final int comicId;
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
            icon: const Icon(Icons.menu_book, color: Colors.white70),
            label: const Text(
              'ابدأ القراءة',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(child: StarRating(comicId: comicId)),
      ],
    );
  }
}
