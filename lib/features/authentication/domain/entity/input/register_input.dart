import 'package:equatable/equatable.dart';

class RegisterInput extends Equatable {
  final String email;
  final String password;
  final String phone;
  final String firstName;
  final String lastName;

  const RegisterInput({
    required this.email,
    required this.password,
    required this.phone,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [email, password, phone, firstName, lastName];
}
