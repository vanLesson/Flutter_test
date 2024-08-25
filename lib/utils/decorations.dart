import 'package:flutter/material.dart';
import 'colors.dart';

InputDecoration getInputDecoration({
  required String hintText,
  required bool isValid,
  required bool wasSubmitted,
}) {
  return InputDecoration(
    hintText: hintText,
    border: _getOutlineInputBorder(color: colorTransparentColor),
    enabledBorder: _getOutlineInputBorder(color: colorTransparentColor),
    focusedBorder: _getFocusedBorder(isValid: isValid, wasSubmitted: wasSubmitted),
    errorBorder: _getOutlineInputBorder(color: colorErrorBorderColor),
    focusedErrorBorder: _getOutlineInputBorder(color: colorErrorBorderColor),
    errorStyle: const TextStyle(height: 0),
    hintStyle: const TextStyle(fontSize: 16, color: colorHintTextColor),
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
  );
}

OutlineInputBorder _getOutlineInputBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: color, width: 1.0),
  );
}

OutlineInputBorder _getFocusedBorder({required bool isValid, required bool wasSubmitted}) {
  if (!wasSubmitted) {
    return _getOutlineInputBorder(color: colorFocusBorderColor);
  } else if (isValid) {
    return _getOutlineInputBorder(color: colorValidBorderColor);
  } else {
    return _getOutlineInputBorder(color: colorErrorBorderColor);
  }
}
