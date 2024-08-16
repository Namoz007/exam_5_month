import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ElevetedButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  Color color;
  Color? textColor;
  ElevetedButtonWidget(
      {super.key,
      required this.color,
      this.onPressed,
      this.textColor,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        elevation: 5,
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}
