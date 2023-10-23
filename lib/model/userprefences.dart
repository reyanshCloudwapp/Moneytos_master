import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytos/model/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(UserDataModel user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('userId', user.id.toString());
    // prefs.setString("authToken", user.authToken.toString());
    prefs.setString('email', user.email.toString());
    prefs.setString('name', user.name.toString());
    prefs.setString('created_at', user.createdAt.toString());
    prefs.setString('image', user.profileImage.toString());
    prefs.setBool('login', true);

    return prefs.commit();
  }

  Future<UserDataModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString('userId');
    // String? authToken = prefs.getString("authToken");
    String? email = prefs.getString('email');
    String? name = prefs.getString('name');
    String? reffered_by = prefs.getString('reffered_by');
    String? email_verified_at = prefs.getString('email_verified_at');
    String? gender = prefs.getString('gender');
    String? contact_number = prefs.getString('contact_number');
    String? created_at = prefs.getString('created_at');
    String? profileimg = prefs.getString('image');
    // bool? is_verified = prefs.getBool("is_verified");

    return UserDataModel(
      id: userId!,
      // authToken: authToken!,
      email: email!,
      name: name!,
      createdAt: created_at!,
      profileImage: profileimg,
      // is_superuser: is_superuser!,
      // is_staff: is_staff!,
      // is_active: is_active!,
      // is_verified: is_verified!
    );
  }

  removeUser(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage(key: GlobalKeys.login_Register,login: true,)));
  }

  // Future<String> getToken(args) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString("token");
  //   return token;
  // }

  Future<SharedPreferences> getSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }
}
