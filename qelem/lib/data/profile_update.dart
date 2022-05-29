import 'dart:convert';
import 'dart:io';

import 'package:qelem/data/remote/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



// get the user profile from the server
Future<UserModel> getProfile(String url, String token) async {

  HttpClient client = HttpClient();
  
  HttpClientRequest request = await client.getUrl(Uri.parse(url));

  request.headers.add(HttpHeaders.authorizationHeader, "Bearer " + token);
  
  HttpClientResponse response = await request.close();

  if (response.statusCode == 200) {

    String responseBody = await response.transform(utf8.decoder).join();
    return UserModel.fromJson(json.decode(responseBody));

  } else {

    throw Exception('Failed to load profile!');
  }

}


// update the user profile on the server from the user model object passed
Future<UserModel> updateProfile(String url, String token, UserModel userModel) async {

  HttpClient client = HttpClient();

  HttpClientRequest request = await client.patchUrl(Uri.parse(url));

  request.headers.add(HttpHeaders.authorizationHeader, "Bearer " + token);

  request.headers.add('content-type', 'application/json');

  request.add(utf8.encode(json.encode(userModel.toJson())));

  HttpClientResponse response = await request.close();

  if (response.statusCode == 200) {

    String responseBody = await response.transform(utf8.decoder).join();
    return UserModel.fromJson(json.decode(responseBody));

  } else {

    throw Exception('Failed to update profile!');
  }

}


// change password 
Future<UserModel> changePassword(String url, String token, String oldPassword, String newPassword) async {

  HttpClient client = HttpClient();

  HttpClientRequest request = await client.patchUrl(Uri.parse(url));
  
  request.headers.add(HttpHeaders.authorizationHeader, "Bearer " + token);

  request.headers.add('content-type', 'application/json');
  request.add(utf8.encode(json.encode({
    "oldPassword": oldPassword,
    "newPassword": newPassword
  })));

  HttpClientResponse response = await request.close();
  if (response.statusCode == 200) {
  
    String responseBody = await response.transform(utf8.decoder).join();
    return UserModel.fromJson(json.decode(responseBody));
  
  } else {
    throw Exception('Failed to change password!');
  }

}

// a function that retrievs access token form shared preferences
getAccessToken() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String accessToken = sharedPreferences.getString("access_token") ?? "";
  return accessToken;
}