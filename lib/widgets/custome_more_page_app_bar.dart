import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class CustomtMorePageAppBar extends StatelessWidget {
  const CustomtMorePageAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: kTextColor),
          ),
          Spacer(flex: 1),
          Text(
            title,
            style: TextStyle(color: kTextColor, fontSize: 32),
          ),
          Spacer(flex: 1),
        ],
      ),
    );
  }
}
