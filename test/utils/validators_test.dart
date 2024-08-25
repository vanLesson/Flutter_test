import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_task/utils/validators.dart';

void main() {
  group('PasswordValidator', () {
    final validator = PasswordValidator();

    test('should return true if password is at least 8 characters long', () {
      expect(validator.isLengthValid('12345678'), isTrue);
      expect(validator.isLengthValid('1234567'), isFalse);
    });

    test('should return true if password has no spaces', () {
      expect(validator.hasNoSpaces('password'), isTrue);
      expect(validator.hasNoSpaces('pass word'), isFalse);
    });

    test('should return true if password has uppercase letter', () {
      expect(validator.hasUpperCase('Password'), isTrue);
      expect(validator.hasUpperCase('password'), isFalse);
    });

    test('should return true if password has lowercase letter', () {
      expect(validator.hasLowerCase('Password'), isTrue);
      expect(validator.hasLowerCase('PASSWORD'), isFalse);
    });

    test('should return true if password has a digit', () {
      expect(validator.hasDigits('Password1'), isTrue);
      expect(validator.hasDigits('Password'), isFalse);
    });

    test('should return true if password meets all criteria', () {
      expect(validator.isValid('Password1'), isTrue);
      expect(validator.isValid('Pass1'), isFalse);
      expect(validator.isValid('password1'), isFalse);
      expect(validator.isValid('PASSWORD1'), isFalse);
      expect(validator.isValid('Password'), isFalse);
    });
  });
}
