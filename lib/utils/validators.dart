class PasswordValidator {
  static const int minLength = 8;

  bool isLengthValid(String password) => password.length >= minLength;

  bool hasNoSpaces(String password) => !password.contains(' ');

  bool hasUpperCase(String password) => password.contains(RegExp(r'[A-Z]'));

  bool hasLowerCase(String password) => password.contains(RegExp(r'[a-z]'));

  bool hasDigits(String password) => password.contains(RegExp(r'[0-9]'));

  bool isValid(String password) {
    return isLengthValid(password) &&
        hasNoSpaces(password) &&
        hasUpperCase(password) &&
        hasLowerCase(password) &&
        hasDigits(password);
  }
}
