import 'package:comic_world/const.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  const CustomPasswordTextFormField({super.key, required this.validator,required this.controller});
  final validator;
  final TextEditingController controller;
  @override
  State<CustomPasswordTextFormField> createState() => _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState extends State<CustomPasswordTextFormField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        suffixIcon: IconButton(icon: Icon(obscure?Icons.visibility :Icons.visibility_off,color: Colors.white54),onPressed: () {
          obscure? obscure=false:obscure=true;
          setState(() {
            
          });
        },),
        hintText: 'كلمة المرور',
        hintStyle: TextStyle(color: Colors.white54),
        prefixIcon: Icon(Icons.lock_outline, color: kTextColor),
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