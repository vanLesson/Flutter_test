import 'package:flutter/material.dart';
import '../utils/validators.dart';
import '../widgets/text_fields.dart';
import '../widgets/submit_button.dart';
import '../widgets/criteria_text.dart';
import '../utils/colors.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final PasswordValidator _passwordValidator = PasswordValidator();

  bool _isPasswordVisible = false;
  bool _wasSubmitted = false;
  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool _hasUpperCase = false;
  bool _hasLowerCase = false;
  bool _initialFocusPassword = false;
  bool _initialFocusEmail = false;

  String _password = '';
  String _email = '';



  void _validatePassword(String value) {
    setState(() {
      _password = value;
      _hasUpperCase = _passwordValidator.hasUpperCase(value);
      _hasLowerCase = _passwordValidator.hasLowerCase(value);
      _isPasswordValid = _passwordValidator.isValid(value);
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _email = value;
      _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
    });
  }

  void _submitForm() {
    setState(() {
      _wasSubmitted = true;
      _initialFocusPassword = true;
      _initialFocusEmail = true;
      _formKey.currentState!.validate();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 94),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: colorPrimary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            EmailField(
              onFocusChange:(focus) {
                if (!focus) {
                  setState(() {
                    _initialFocusEmail = true;
                  });
                }
              } ,
              onChanged: _validateEmail,
              wasSubmitted: _initialFocusEmail,
              isValid: _isEmailValid,
            ),
            const SizedBox(height: 20),
            PasswordField(
              onFocusChange: (focus) {
                if (!focus) {
                  setState(() {
                    _initialFocusPassword = true;
                  });
                }
              },
              onChanged: _validatePassword,
              wasSubmitted: _initialFocusPassword,
              isValid: _isPasswordValid,
              isPasswordVisible: _isPasswordVisible,
              toggleVisibility: () =>
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  }),
            ),
            const SizedBox(height: 20),
            PasswordCriteria(
              text: '8 characters or more (no spaces)',
              isValid: _passwordValidator.isLengthValid(_password) &&
                  _passwordValidator.hasNoSpaces(_password),
              passWasFocused: _initialFocusPassword,
            ),
            const SizedBox(height: 4),
            PasswordCriteria(
              text: 'Uppercase and lowercase letters',
              isValid: _hasUpperCase && _hasLowerCase,
              passWasFocused: _initialFocusPassword,
            ),
            const SizedBox(height: 4),
            PasswordCriteria(
              text: 'At least one digit',
              isValid: _passwordValidator.hasDigits(_password),
              passWasFocused: _initialFocusPassword,
            ),
            const SizedBox(height: 40),
            SubmitButton(
              onPressed: _password.isNotEmpty && _email.isNotEmpty
                  ? _submitForm
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
