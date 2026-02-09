import 'package:comic_world/widgets/menu_sheet.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class CustomHomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xff201E2C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // ☰ MENU
          IconButton(
            icon: Icon(Icons.menu, color: kTextColor),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: kThemeColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => MenuSheet(),
              );
            },
          ),

          // SEARCH FIELD
          Expanded(
            child: TextField(
              style: TextStyle(color: kTextColor),
              decoration: InputDecoration(
                hintText: 'ابحث عن كوميك...',
                hintStyle: TextStyle(color: kTextColor.withValues(alpha: 0.5)),
                border: InputBorder.none,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search, color: kTextColor),
          ),
        ],
      ),
    );
  }
}
