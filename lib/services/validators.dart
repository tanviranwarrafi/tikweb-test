import 'package:email_validator/email_validator.dart';

class Validators {
  String validateEmail({String value}) {
    if (value.length == 0)
      return "Please enter your email";
    else if (!EmailValidator.validate(value))
      return "Please enter valid email";
    else
      return null;
  }

  String validatePassword({String value}) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String validateName({String value}) {
    if (value.isEmpty) {
      return 'Please write your name';
    }
    return null;
  }

  String validatePhone({String value}) {
    if (value.isEmpty) {
      return 'Please enter your phone no';
    } else if (value.length < 11) {
      return 'Phone no must be 11 characters';
    } else if (value.length > 11) {
      return 'Phone no must be 11 characters';
    }
    return null;
  }
}
