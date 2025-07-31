import 'dart:io';

class AuthCookie implements Cookie {
  @override
  String? domain;

  @override
  DateTime? expires;

  @override
  bool httpOnly;

  @override
  int? maxAge;

  @override
  String name = 'token';

  @override
  String? path;

  @override
  SameSite? sameSite;

  @override
  bool secure = true;

  @override
  String value;

  AuthCookie({required this.value, required this.httpOnly});
}
