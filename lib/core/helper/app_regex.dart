import 'package:intl_phone_field/phone_number.dart';

class AppRegex {
  RegExp letterRegex = RegExp(r'^[a-zA-Z]+$');

  static bool isValidPhone(PhoneNumber phone) {
    return RegExp(r"^01[0-5]\d{8}$").hasMatch(phone.toString());
  }

  static final validEmailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );
  static const String validPhoneNumberRegex = r"^01[0-5]\d{8}$";
  static const String validPasswordRegex =
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$";
  static RegExp lowerCaseLetterRegex = RegExp(r'^(?=.*[a-z])');

  static RegExp upperCaseLetterRegex = RegExp(r'^(?=.*[A-Z])');
  static RegExp digitCaseLetterRegex = RegExp(r'^(?=.*\d)');
  static RegExp specialCharacterCaseLetterRegex = RegExp(r'^(?=.*[@$!%*?&])');
}

String? passwordValidator(String value) {
  if (!AppRegex.lowerCaseLetterRegex.hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!AppRegex.upperCaseLetterRegex.hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!AppRegex.digitCaseLetterRegex.hasMatch(value)) {
    return 'Password must contain at least one digit';
  }
  if (!AppRegex.specialCharacterCaseLetterRegex.hasMatch(value)) {
    return 'Password must contain at least one special character';
  }
  return null;
}
