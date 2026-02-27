import 'package:comic_world/views/comic_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:comic_world/const.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final Future<dynamic> Function() request;
   const SectionTitle({super.key, required this.title, required this.request});

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
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ComicGridView(dataFunc:()=> request(),title: title,),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kThemeColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('عرض المزيد', style: TextStyle(color: kTextColor)),
        ),
      ],
    );
  }
}
