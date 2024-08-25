import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PasswordCriteria extends StatelessWidget {
  final String text;
  final bool isValid;
  final bool passWasFocused;

  const PasswordCriteria({
    super.key,
    required this.text,
    required this.isValid,
    required this.passWasFocused,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: isValid
                ? colorValidHint
                : (passWasFocused ? colorErrorBorderColor : colorPrimary),
          ),
        ));
  }
}
