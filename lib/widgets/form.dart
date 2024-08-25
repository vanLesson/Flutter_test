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
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();

  bool _isPasswordVisible = false;
  bool _wasSubmitted = false;
  bool _isPasswordValid = false;
  bool _isEmailValid = false;
  bool _passWasFocused = false;
  bool _hasUpperCase = false;
  bool _hasLowerCase = false;

  String _password = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(_onPasswordFocusChange);
  }

  void _onPasswordFocusChange() {
    if (_passwordFocusNode.hasFocus) {
      setState(() {
        _passWasFocused = true;
      });
    }
  }

  void _validatePassword(String value) {
    setState(() {
      _password = value;
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _email = value;
    });
  }

  void _submitForm() {
    setState(() {
      _wasSubmitted = true;
      _formKey.currentState!.validate();
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    super.dispose();
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
              focusNode: _emailFocusNode,
              onChanged: _validateEmail,
              wasSubmitted: _wasSubmitted,
              isValid: _isEmailValid,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                _isEmailValid = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value);
                return null;
              },
            ),
            const SizedBox(height: 20),
            PasswordField(
              focusNode: _passwordFocusNode,
              onChanged: _validatePassword,
              wasSubmitted: _wasSubmitted,
              isValid: _isPasswordValid,
              isPasswordVisible: _isPasswordVisible,
              validate: (value) {
                if (value == null || value.isEmpty) {
                  return null;
                }
                _hasUpperCase = _passwordValidator.hasUpperCase(value);
                _hasLowerCase = _passwordValidator.hasLowerCase(value);
                _isPasswordValid = _passwordValidator.isValid(value);
                return null;
              },
              toggleVisibility: () => setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              }),
            ),
            const SizedBox(height: 20),

            PasswordCriteria(
              text: '8 characters or more (no spaces)',
              isValid: _passwordValidator.isLengthValid(_password) &&
                  _passwordValidator.hasNoSpaces(_password),
              passWasFocused: _passWasFocused,
            ),
            const SizedBox(height: 4),
            PasswordCriteria(
              text: 'Uppercase and lowercase letters',
              isValid: _hasUpperCase && _hasLowerCase,
              passWasFocused: _wasSubmitted,
            ),
            const SizedBox(height: 4),
            PasswordCriteria(
              text: 'At least one digit',
              isValid: _passwordValidator.hasDigits(_password),
              passWasFocused: _passWasFocused,
            ),
            const SizedBox(height: 40),

            SubmitButton(
              onPressed: _password.isNotEmpty && _email.isNotEmpty ? _submitForm : null,
            ),
          ],
        ),
      ),
    );
  }
}
