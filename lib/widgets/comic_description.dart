import 'package:flutter/material.dart';

class ComicDescription extends StatelessWidget {
  const ComicDescription({super.key, required this.description});
  final String description;
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: TextStyle(color: Colors.white70, height: 1.6),
    );
  }
}