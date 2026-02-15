import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class CustomFormButton extends StatelessWidget {
  const CustomFormButton({super.key, 
    required this.text,
    required this.onpressed
  });
  final String text;
  final void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: kTextColor),
        ),
      ),
    );
  }
}
