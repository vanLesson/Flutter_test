import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';

class EmailField extends StatelessWidget {
  final void Function(String) onChanged;
  final bool wasSubmitted;
  final bool isValid;
  final ValueChanged<bool>? onFocusChange;

  const EmailField({
    super.key,
    required this.onChanged,
    required this.wasSubmitted,
    required this.isValid,
    required this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 315,
        height: 48,
        decoration: BoxDecoration(
          color: wasSubmitted
              ? (isValid ? colorValidBackground : colorInValidBackground)
              : colorWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Focus(
            onFocusChange: onFocusChange,
            child: TextFormField(
              onChanged: onChanged,
              decoration: getInputDecoration(
                hintText: 'Email',
                isValid: isValid,
                wasSubmitted: wasSubmitted,
              ),
            )));
  }
}

class PasswordField extends StatelessWidget {
  final void Function(String) onChanged;
  final bool wasSubmitted;
  final bool isValid;
  final bool isPasswordVisible;

  final VoidCallback toggleVisibility;
  final ValueChanged<bool>? onFocusChange;

  const PasswordField({
    super.key,
    required this.onChanged,
    required this.wasSubmitted,
    required this.isValid,
    required this.isPasswordVisible,
    required this.toggleVisibility,
    required this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 315,
        height: 48,
        decoration: BoxDecoration(
          color: wasSubmitted
              ? (isValid ? colorValidBackground : colorInValidBackground)
              : colorWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Focus(
          onFocusChange: onFocusChange,
          child: TextFormField(
            onChanged: onChanged,
            obscureText: !isPasswordVisible,
            decoration: getInputDecoration(
              hintText: 'Enter your password',
              isValid: isValid,
              wasSubmitted: wasSubmitted,
            ).copyWith(
              suffixIcon: IconButton(
                icon: SvgPicture.asset(
                  isPasswordVisible
                      ? 'assets/images/ShowPassIcon.svg'
                      : 'assets/images/HidePassIcon.svg',
                  width: 16,
                  height: 12,
                  colorFilter:
                      const ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                ),
                onPressed: toggleVisibility,
              ),
            ),
          ),
        ));
  }
}
