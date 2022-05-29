import 'dart:convert';

String userModelToJson(UserModel userModel) => json.encode(userModel.toJson());

class UserModel {
  String username;
  String password;
  String firstName;
  String lastName;
  String role;
  String profilePicture;

  UserModel(
      {required this.username,
      required this.firstName,
      required this.lastName,
      required this.password,
      this.role = "MEMBER",
      required this.profilePicture});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      firstName: json["firstName"],
      lastName: json["lastName"],
      username: json["username"],
      password: json["password"],
      role: json["role"],
      profilePicture: json["profilePicture"]);

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "password": password,
      };

  String get firstname => firstName;
  String get lastname => lastName;
}