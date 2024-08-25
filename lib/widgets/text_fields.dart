import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';
import '../utils/decorations.dart';

class EmailField extends StatelessWidget {
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final bool wasSubmitted;
  final bool isValid;
  final String? Function(String?)? validate;

  const EmailField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.wasSubmitted,
    required this.isValid,
    required this.validate,
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
      child: TextFormField(
        focusNode: focusNode,
        onChanged: onChanged,
        decoration: getInputDecoration(
          hintText: 'Email',
          isValid: isValid,
          wasSubmitted: wasSubmitted,
        ),
        validator: validate,
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final bool wasSubmitted;
  final bool isValid;
  final bool isPasswordVisible;
  final String? Function(String?)? validate;
  final VoidCallback toggleVisibility;

  const PasswordField({
    super.key,
    required this.focusNode,
    required this.onChanged,
    required this.wasSubmitted,
    required this.isValid,
    required this.isPasswordVisible,
    required this.validate,
    required this.toggleVisibility,
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
      child: TextFormField(
        validator: validate,
        onChanged: onChanged,
        focusNode: focusNode,
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
              colorFilter: const ColorFilter.mode(colorPrimary, BlendMode.srcIn),
            ),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }
}
