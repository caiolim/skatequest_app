import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final void Function()? onPressed;

  const ButtonWidget({
    super.key,
    this.text = '',
    this.width = double.infinity,
    this.height = 48.0,
    this.color = Colors.white,
    this.textColor = Colors.black,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(width, height),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
