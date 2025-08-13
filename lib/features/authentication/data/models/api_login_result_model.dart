// To parse this JSON data, do
//
//     final apiSignInResultModel = apiSignInResultModelFromJson(jsonString);

class ApiSignInResultModel {
  final String? message;
  final String? token;
  final ApiUserModel? user;

  ApiSignInResultModel({this.message, this.token, this.user});

  factory ApiSignInResultModel.fromJson(Map<String, dynamic> json) =>
      ApiSignInResultModel(
        message: json["message"],
        token: json["token"],
        user: json["user"] == null ? null : ApiUserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class ApiUserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? address;
  final String? city;
  final String? role;
  final String? image;
  final bool? isVerified;
  final String? token;
  final dynamic verificationToken;
  final dynamic verificationExpires;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final bool? resetPasswordAllowed;
  final List<dynamic>? cartItems;

  ApiUserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.role,
    this.password,
    this.address,
    this.city,
    this.image,
    this.isVerified,
    this.token,
    this.verificationToken,
    this.verificationExpires,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.resetPasswordAllowed,
    this.cartItems,
  });

  factory ApiUserModel.fromJson(Map<String, dynamic> json) => ApiUserModel(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    address: json["address"],

    city: json["city"],
    role: json["role"],
    image: json["image"],
    isVerified: json["isVerified"],
    token: json["token"],
    verificationToken: json["verificationToken"],
    verificationExpires: json["verificationExpires"],
    isDeleted: json["isDeleted"],
    createdAt:
        json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt:
        json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    resetPasswordAllowed: json["resetPasswordAllowed"],
    cartItems:
        json["cartItems"] == null
            ? []
            : List<dynamic>.from(json["cartItems"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "phone": phone,
    "address": address,
    "city": city,
    "role": role,
    "image": image,
    "isVerified": isVerified,
    "token": token,
    "verificationToken": verificationToken,
    "verificationExpires": verificationExpires,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "resetPasswordAllowed": resetPasswordAllowed,
    "cartItems":
        cartItems == null ? [] : List<dynamic>.from(cartItems!.map((x) => x)),
  };
}
