import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String avatar;
  final String fullName;
  final String jobTitle;
  final String gender;
  final String countryName;
  final String cityName;
  final String cityPicture;

  UserModel({
    required this.id,
    required this.avatar,
    required this.fullName,
    required this.jobTitle,
    required this.gender,
    required this.countryName,
    required this.cityName,
    required this.cityPicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      avatar: json['avatar'],
      fullName: json['full_name'],
      jobTitle: json['job_title'],
      gender: json['gender'],
      countryName: json['country_name'],
      cityName: json['city_name'],
      cityPicture: json['city_picture'],
    );
  }
}

