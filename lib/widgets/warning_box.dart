import 'package:flutter/material.dart';

class WarningBox extends StatelessWidget {
  const WarningBox({required this.warning});
  final String warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        warning,
        style: TextStyle(color: Colors.redAccent),
      ),
    );
  }
}