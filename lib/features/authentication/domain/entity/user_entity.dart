import 'package:equatable/equatable.dart';

class UserInfoEntity extends Equatable {
  final String? username;
  final ExpertData? expert;
  final String? firstName;
  final String? lastName;
  final String? profilePicture;
  final String? fullName;
  final String? id;
  final ExpertRequestStatus? expertRequestStatus;
  final String? role;
  final int? followersCount;
  final int? followingsCount;
  final int? notificationCount;
  final bool? isFollowed;
  final AddressData? address;
  final int? birthDate;
  final bool? isBlocked;
  final String? verifiedEmail;
  final String? phone;
  final bool? hasCompletedProfile;
  final int? messageCount;
  final String? token;

  const UserInfoEntity({
    this.verifiedEmail,
    this.phone,
    this.birthDate,
    this.username,
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.fullName,
    this.id,
    this.role,
    this.followersCount,
    this.followingsCount,
    this.notificationCount,
    this.isFollowed,
    this.address,
    this.expert,
    this.expertRequestStatus,
    this.isBlocked,
    this.hasCompletedProfile,
    this.messageCount,
    this.token,
  });

  UserInfoEntity copyWith({
    int? birthDate,
    String? username,
    ExpertData? expert,
    String? firstName,
    ExpertRequestStatus? expertRequestStatus,
    String? lastName,
    String? profilePicture,
    String? fullName,
    String? id,
    String? role,
    int? followersCount,
    int? followingsCount,
    int? notificationCount,
    bool? isFollowed,
    AddressData? address,
    String? verifiedEmail,
    String? phone,
    bool? isBlocked,
    bool? hasCompletedProfile,
    int? messageCount,
    String? token,
  }) {
    return UserInfoEntity(
      birthDate: birthDate ?? this.birthDate,
      username: username ?? this.username,
      expert: expert ?? this.expert,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePicture: profilePicture ?? this.profilePicture,
      fullName: fullName ?? this.fullName,
      id: id ?? this.id,
      role: role ?? this.role,
      followersCount: followersCount ?? this.followersCount,
      followingsCount: followingsCount ?? this.followingsCount,
      notificationCount: notificationCount ?? this.notificationCount,
      isFollowed: isFollowed ?? this.isFollowed,
      address: address ?? this.address,
      expertRequestStatus: expertRequestStatus ?? this.expertRequestStatus,
      verifiedEmail: verifiedEmail ?? this.verifiedEmail,
      phone: phone ?? this.phone,
      isBlocked: isBlocked ?? this.isBlocked,
      hasCompletedProfile: hasCompletedProfile ?? this.hasCompletedProfile,
      messageCount: messageCount ?? this.messageCount,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
    birthDate,
    username,
    expert,
    firstName,
    lastName,
    profilePicture,
    fullName,
    id,
    role,
    followersCount,
    followingsCount,
    notificationCount,
    isFollowed,
    address,
    expertRequestStatus,
    verifiedEmail,
    phone,
    isBlocked,
    hasCompletedProfile,
    messageCount,
    token,
  ];
}

class ExpertData extends Equatable {
  final String? bio;
  final SpecialitiesEntity? specialty;
  final List<String>? socialLinks;
  final String? id;

  const ExpertData({this.id, this.bio, this.specialty, this.socialLinks});

  ExpertData reduce({
    String? bio,
    SpecialitiesEntity? specialty,
    List<String>? socialLinks,
    String? id,
  }) {
    return ExpertData(
      id: id ?? this.id,
      bio: bio ?? this.bio,
      socialLinks: socialLinks ?? this.socialLinks,
      specialty: specialty ?? this.specialty,
    );
  }

  @override
  List<Object?> get props => [bio, specialty, socialLinks, id];
}

class AddressData extends Equatable {
  final AddressInfoEntity? city;
  final AddressInfoEntity? country;
  final AddressInfoEntity? state;

  const AddressData({this.city, this.country, this.state});

  AddressData reduce({
    AddressInfoEntity? city,
    AddressInfoEntity? country,
    AddressInfoEntity? state,
  }) {
    return AddressData(
      city: city ?? this.city,
      country: country ?? this.country,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [city, country, state];
}
// ignore: constant_identifier_names
enum ExpertRequestStatus { PENDING, ACCEPTED, REJECTED }

class AddressInfoEntity extends Equatable {
  final String name;
  final String id;

  const AddressInfoEntity({required this.name, required this.id});
  @override
  List<Object?> get props => [name, id];
}

class SpecialitiesEntity extends Equatable {
  final String name;
  final String id;

  const SpecialitiesEntity({required this.name, required this.id});

  @override
  List<Object?> get props => [name, id];
}
