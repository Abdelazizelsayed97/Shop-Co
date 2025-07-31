const String appEndpoint = "https://shop-co-api-dev.up.railway.app/";

class ConstStrings {
  static const String baseUrl = "https://api.escuelajs.co/graphql";
  static const String token = "token";
  static const String userId = "userId";
}

class EndPoints {
  static const String login = "login";
  static const String register = "register";
  static const String products = "https://dummyjson.com/products";
}

class AuthEndPoints {
  const AuthEndPoints._();

  static const String loginEndPoint = "auth/login";
  static const String forgetPassword = "auth/forgot-password";
  static const String resetPassword = "auth/reset-password";
  static const String verifyResetOtp = "auth/verify-reset-otp";
  static const String verifyEmail = "auth/verify-email-otp";
  static const String registerEndPoint = "auth/register";
  static const String productsEndPoint = "products";
  static const String token = "token";
  static const localhost = "localhost:8000";
  static const String logOutEndPoint = "auth/logout";
}

class ProfileEndPoints {
  const ProfileEndPoints._();
  static const String getUserById = "users";
}
