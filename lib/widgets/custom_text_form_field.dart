import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.hint,required this.validator,required this.controller,this.icon,this.maxLines=1});
  final String hint;
  final IconData? icon;
  final validator;
  final int maxLines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      validator: validator,
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon:icon==null?null: Icon(icon, color: kTextColor),
        filled: true,
        fillColor: const Color(0xFF1A1A22),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}