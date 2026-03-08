import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class CustomShowDialog extends StatelessWidget {
  final String title;
  final String buttonText;
  final  void Function()? onPressed;
  const CustomShowDialog({
    required this.title,
    required this.buttonText,
    this.onPressed
      });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: kThemeColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // دائرة العلامة صح
            Image.asset('assets/images/success.png'),

            const SizedBox(height: 20),

            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            // الزرار
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:onPressed ?? ()=>Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor:const Color(0xFF8AE041),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Color(0xFF0B2C67),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
     ),
);
}
}