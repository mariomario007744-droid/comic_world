import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Image.asset(
            'assets/images/IMG_20260202_213638.png',
          ),
        ),
        SizedBox(height: 12),
        Text(
          'عالم الكوميكس',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
