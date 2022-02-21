import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_jwt_auth_example/exceptions/user_exceptions.dart';
import 'package:flutter_jwt_auth_example/services/auth_service.dart';

class User {
  final int id;
  String email;
  String firstName;
  String lastName;
  String cellphone;
  String accessToken;
  String refreshToken;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.cellphone,
    required this.accessToken,
    required this.refreshToken,
  }) {
    if (isValidRefreshToken()) {
      getNewToken();
    } else {
      throw InvalidUserException();
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final user = User(
      id: json['userId'],
      email: json['userEmail'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      cellphone: json['userCellphone'],
      accessToken: json['access'],
      refreshToken: json['refresh'],
    );
    if (user.isValidRefreshToken()) {
      return user;
    } else {
      throw InvalidUserException();
    }
  }

  String fullName() {
    return firstName + ' ' + lastName;
  }

  bool isValidRefreshToken() {
    final jwtData = JwtDecoder.decode(refreshToken);
    return jwtData['exp'] < DateTime.now().millisecondsSinceEpoch;
  }

  void getNewToken() async {
    final jwtData = JwtDecoder.decode(accessToken);
    await Future.delayed(
      Duration(
        milliseconds:
            jwtData['exp'] * 1000 - DateTime.now().millisecondsSinceEpoch,
      ),
      () async {
        try {
          await AuthService.refreshToken(this);
        } catch (e) {}
      },
    );
    getNewToken();
  }

  String toJson() {
    return jsonEncode(
      {
        'userId': id,
        'userEmail': email,
        'userCellphone': cellphone,
        'userFirstName': firstName,
        'userLastName': lastName,
        "access": accessToken,
        "refresh": refreshToken,
      },
    );
  }
}
