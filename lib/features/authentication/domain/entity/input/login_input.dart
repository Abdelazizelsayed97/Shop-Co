import 'package:equatable/equatable.dart';

class LoginInput extends Equatable {
  final String email;
  final String password;

  const LoginInput({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginDetails extends Equatable {
  final String deviceName;
  final String deviceModel;
  final String deviceVersion;
  final String deviceType;
  final String deviceToken;

  const LoginDetails({
    required this.deviceName,
    required this.deviceModel,
    required this.deviceVersion,
    required this.deviceType,
    required this.deviceToken,
  });

  @override
  List<Object?> get props => [
    deviceName,
    deviceModel,
    deviceVersion,
    deviceType,
    deviceToken,
  ];
}
