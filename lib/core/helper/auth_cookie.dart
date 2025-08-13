import 'dart:async';
import 'dart:io';

import 'package:e_commerce_web_app/core/utils/local_hive_storage.dart';
import 'package:e_commerce_web_app/features/authentication/domain/entity/user_entity.dart';

class AuthCookie implements Future<Cookie> {
  final UserInfoEntity? userInfoEntity;
  String? domain;

  DateTime? expires;

  bool httpOnly;

  int? maxAge;

  String name = 'token';

  String? path;

  SameSite? sameSite;

  bool secure = true;

  String value;

  AuthCookie({
    required this.value,
    required this.httpOnly,
    this.userInfoEntity,
  });

  @override
  Stream<Cookie> asStream() {
    throw UnimplementedError();
  }

  @override
  Future<Cookie> catchError(
    Function onError, {
    bool Function(Object error)? test,
  }) {
    return Future.value(this);
  }

  @override
  Future<R> then<R>(
    FutureOr<R> Function(Cookie value) onValue, {
    Function? onError,
  }) {
    return Future.value(
      HiveStorageService.service
          .getModel(
            boxName: "CurrentUser",
            key: "CurrentUser",
            fromJson: (p0) => UserInfoEntity.fromJson(p0),
          )
          .then((value) => onValue(Cookie(name, value?.token ?? ""))),
    );
  }

  @override
  Future<Cookie> timeout(
    Duration timeLimit, {
    FutureOr<Cookie> Function()? onTimeout,
  }) {
    // TODO: implement timeout
    throw UnimplementedError();
  }

  @override
  Future<Cookie> whenComplete(FutureOr<void> Function() action) {
    // TODO: implement whenComplete
    throw UnimplementedError();
  }
}
