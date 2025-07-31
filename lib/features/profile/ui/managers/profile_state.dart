part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final Async<UserInfoEntity> fetchUserData;
  final Async<void> logOut;

  const ProfileState({required this.fetchUserData, required this.logOut});
  factory ProfileState.initial() {
    return ProfileState(
      fetchUserData: Async.initial(),
      logOut: Async.initial(),
    );
  }
  ProfileState reduce({
    Async<UserInfoEntity>? fetchUserData,
    Async<void>? logOut,
  }) {
    return ProfileState(
      fetchUserData: fetchUserData ?? this.fetchUserData,
      logOut: logOut ?? this.logOut,
    );
  }

  @override
  List<Object?> get props => [fetchUserData, logOut];
}
