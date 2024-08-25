import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const SubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: onPressed != null ? 1.0 : 0.5,
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            width: 240,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [colorButtonGradientStart, colorButtonGradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
