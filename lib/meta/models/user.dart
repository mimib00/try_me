import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String uid;
  final String email;
  final String name;
  final String username;
  final String photo;

  Users(
    this.uid,
    this.email,
    this.name,
    this.username,
    this.photo,
  );
  factory Users.fromJson(Map<String, dynamic> data, String uid) {
    return Users(
      uid,
      data["email"],
      data["name"],
      data["username"],
      data["photo"],
    );
  }
}
