import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: kTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: kThemeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('عرض الكل', style: TextStyle(color: kTextColor)),
        ),
      ],
    );
  }
}
