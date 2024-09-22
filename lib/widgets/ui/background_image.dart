import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final String imagePath;
  final AlignmentGeometry  alignment;

  const BackgroundImage({super.key,
    required this.child,
    required this.imagePath,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: alignment,
          child: child,
        ),
      ],
    );
  }
}
