import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project/model_classes/usermodel.dart';

ValueNotifier<List<UserModel>> userListNotifier = ValueNotifier([]);

late Box<UserModel> userBox;

Future<void> addUser(UserModel user) async {
  final userBox = await Hive.openBox<UserModel>('user_db');



  if (userBox.values.isEmpty) {
      user.isLoggedIn = true;
    userBox.add(user);

  } else {
    userBox.putAt(0, user);
    log('user updatedddddd');
  }
}

Future<void> addUserPhoto(UserModel user) async {
  final userBox = await Hive.openBox<UserModel>('user_db');
  userBox.putAt(0, user);
}

Future<UserModel?> getUser() async {
  final userBox = await Hive.openBox<UserModel>('user_db');
  // final int? index = sharedPref.getInt(signUp);
  // final value = userBox.getAt(0);
    final value = userBox.isNotEmpty ? userBox.getAt(0) as UserModel? : null;
  // log('index>>>>>>>>>>>>>>>>>>$index');
  if (value != null) {
    log("Returned name${value.name}");
    return value;
  }
  return null;
}
