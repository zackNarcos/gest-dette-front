import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool filled;
  final Color fillColor;
  final Color textColor;
  final Color borderColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final bool outlineBorder;
  final double fontSize;


  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.filled = true,
    this.fillColor = Colors.white,
    this.textColor = DLivColors.label,
    this.borderColor = DLivColors.muted,
    this.enabledBorderColor = DLivColors.muted,
    this.focusedBorderColor = Colors.blue,
    this.outlineBorder = false,
    this.fontSize = 16
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          filled ? fillColor : Colors.transparent,
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 0,
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>(
          const Size(double.infinity, 47),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
            side: BorderSide(
              color: outlineBorder ? borderColor : Colors.transparent,
            ),
          ),
        ),
      ),

      child: Text(
          text,
          style: TextStyle(
            color: filled ? textColor : DLivColors.primary,
            fontSize: fontSize,
          ),
      ),
    );
  }
}