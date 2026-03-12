import 'dart:async';

import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class CheckNetwork extends StatelessWidget{
  CheckNetwork({required this.getData});
  final  Future<dynamic> Function() getData;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
    Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.wifi_off,color: kTextColor,),
        Text('انقطع الاتصال بالانترنت',style: TextStyle(color: kTextColor)),
      ],
    ),
    ElevatedButton(style: ElevatedButton.styleFrom(
      backgroundColor: kThemeColor
    ),onPressed: (){
      Timer(Duration(seconds: 1), getData);
    }, child: Text('إعادة المحاولة',style: TextStyle(color: kTextColor),)),
  ],);
  }
}