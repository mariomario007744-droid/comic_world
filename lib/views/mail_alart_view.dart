import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class MailAlartView extends StatelessWidget {
  const MailAlartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: const Scaffold(
        backgroundColor: kBackgroundColor,
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('تم إرسال رسالة إلى بريدك الإلكتروني تحتوي على رابط لإعادة تعيين كلمة المرور',style: TextStyle(fontSize: 18,color: Colors.white),),
          ),
        ),
      ),
    );
  }
}