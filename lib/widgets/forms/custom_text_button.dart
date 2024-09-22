import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Widget content;
  final VoidCallback onPressed;
  late Color bgColor;
  late bool displayBgOnPressed;

  CustomTextButton({
    required this.content,
    required this.onPressed,
    this.bgColor = Colors.white,
    this.displayBgOnPressed = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return displayBgOnPressed ? Colors.grey.withOpacity(0.5) : Colors.transparent;
          }
          return Colors.transparent;
        }),
        overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.3)),
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Pas de bordure arrondie
        )),
      ),
      onPressed: onPressed,
      child: content,
    );
  }
}