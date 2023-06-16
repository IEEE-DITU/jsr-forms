import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile extends Equatable {
  final String? email;
  final String id;
  final String? name;
  final String? profileUrl;
  final bool isEmailVerified;

  const UserProfile(
      {this.email,
      required this.id,
      this.name,
      this.profileUrl,
      this.isEmailVerified = false});

  @override
  List<Object?> get props => [email, id, name, profileUrl, isEmailVerified];

  factory UserProfile.fromUser(User user) {
    return UserProfile(
        id: user.uid,
        email: user.email,
        name: user.displayName,
        profileUrl: user.photoURL,
        isEmailVerified: user.emailVerified);
  }
  static UserProfile empty = const UserProfile(id: "");
}
