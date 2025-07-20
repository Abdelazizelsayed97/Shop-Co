// To parse this JSON data, do
//
//     final apiSignInResultModel = apiSignInResultModelFromJson(jsonString);

class ApiSignInResultModel {
  final String? message;
  final String? token;
  final User? user;

  ApiSignInResultModel({this.message, this.token, this.user});

  factory ApiSignInResultModel.fromJson(Map<String, dynamic> json) =>
      ApiSignInResultModel(
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? role;

  User({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "role": role,
  };
}
