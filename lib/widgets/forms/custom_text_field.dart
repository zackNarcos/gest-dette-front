import 'package:d_liv/shared/constants/theme/colors.dart';
import 'package:flutter/material.dart';


class CustomTextField extends StatefulWidget {
  final String? placeholder;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool autofocus;
  final Color borderColor;
  final bool filled;
  final Color? fillColor;
  final Color textColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final bool outlineBorder;
  final Color cursorColor;
  final Color hintTextColor;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? errorText;
  final int? maxLength;

  const CustomTextField({
    super.key,
    this.label,
    this.placeholder,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.textColor = Colors.black,
    this.enabledBorderColor = DLivColors.muted,
    this.focusedBorderColor = DLivColors.primary,
    this.cursorColor = DLivColors.muted,
    this.hintTextColor = DLivColors.muted,
    this.onChanged,
    this.outlineBorder = true,
    this.autofocus = false,
    this.borderColor = DLivColors.border,
    this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.errorText,
    this.maxLength,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText ? _isObscured : false,
      style: TextStyle(
        height: 1.0,
        fontSize: 14.0,
        color: widget.textColor,
      ),
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        // contentPadding: EdgeInsets.only(left: 16, bottom: widget.outlineBorder ? 20 : 16),
        labelText: widget.label,
        labelStyle: TextStyle(
          color: widget.hintTextColor,
        ),
        errorText: widget.errorText,
        filled: widget.filled,
        fillColor: widget.fillColor,
        hintStyle: TextStyle(
          color: widget.hintTextColor,
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility : Icons.visibility_off,
                  // color: widget.hintTextColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        enabledBorder: widget.outlineBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(color: widget.enabledBorderColor),
                borderRadius: BorderRadius.circular(16.0),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(color: widget.enabledBorderColor)
            ),
        focusedBorder: widget.outlineBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(color: widget.focusedBorderColor),
                borderRadius: BorderRadius.circular(16.0),
              )
            : UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.focusedBorderColor)
            ),
        hintText: widget.placeholder,
      ),
    );
  }
}