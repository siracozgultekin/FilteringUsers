import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/userModel.dart';


Future<List<UserModel>> getUsers() async {
  final response = await http.get(Uri.parse('https://api.jsonserve.com/FOh0Q6'));

  if (response.statusCode == 200) {
    final List<dynamic> usersJson = jsonDecode(response.body);
    return  usersJson.map((json) => UserModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

List<UserModel> filteringUsersCountry(List<UserModel> userlist,String Country){
  int i=0;
  List<UserModel> filteredUsers=[];
  while(i<userlist.length){
   if(userlist[i].countryName.toLowerCase().contains(Country.toLowerCase())){
     filteredUsers.add(userlist[i]);
   }else{}
   i++;
  }
return filteredUsers;
}

List<UserModel> filteringUsersCity(List<UserModel> userlist,String City){
  int i=0;
  List<UserModel> filteredUsers=[];
  while(i<userlist.length){
    if(userlist[i].cityName.toLowerCase().contains(City.toLowerCase())){
      filteredUsers.add(userlist[i]);
    }else{}
    i++;
  }
  return filteredUsers;
}
List<UserModel> filteringUsersFullname(List<UserModel> userlist,String Fullname){
  int i=0;
  List<UserModel> filteredUsers=[];
  while(i<userlist.length){
    if(userlist[i].fullName.toLowerCase().contains(Fullname.toLowerCase())){
      filteredUsers.add(userlist[i]);
    }else{}
    i++;
  }
  return filteredUsers;
}