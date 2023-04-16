import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gfgprojects/models/user.dart';

class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser(User user) async {
    await _db
        .collection("data/users/profile")
        .add(user.toJson())
        .whenComplete(
          () => GetSnackBar(
            title: "SUCCESS",
            messageText: Text("Your account has been successfully created."),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            snackStyle: SnackStyle.FLOATING,
          ),
        )
        .catchError((error, stackTrace) {
      Get.snackbar(
        "ERROR",
        "Something went wrong.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.indigoAccent.withOpacity(0.1),
        colorText: Colors.black87,
      );
      print(error.toString());
    });
  }
}
