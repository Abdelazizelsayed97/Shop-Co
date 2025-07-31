import 'package:e_commerce_web_app/features/authentication/data/models/api_login_result_model.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

extension ConvertLoginResultToEntity on ApiUserModel {
  UserInfoEntity convertToEntity() {
    return UserInfoEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      token: token,
      verifiedEmail: email,
    );
  }
}
