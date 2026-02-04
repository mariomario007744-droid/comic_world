import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
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
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: Image.asset(
          'assets/images/free-google-icon-svg-download-png-189824.png',
          height: 22,
        ),
        label: Text(
          text,
          style: TextStyle(fontSize: 16),
        ),
        onPressed: onpressed
      ),
    );
  }
}

