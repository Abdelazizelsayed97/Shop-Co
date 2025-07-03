import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

class ReviewEntity {
  final String? id;
  final UserInfoEntity? user;
  final String? description;

  int? rate;

  ReviewEntity({this.user, this.id, this.description, this.rate});
}
