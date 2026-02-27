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
            'assets/images/Picsart_26-02-19_03-22-53-564.png',
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
