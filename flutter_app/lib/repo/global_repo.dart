import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gfgprojects/models/user.dart';

class GlobalRepo extends GetxController {
  static GlobalRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  Updatedata(data) async {
    await _db
        .collection("data/global stats")
        .parameters
        .update(data, (value) => null);
  }
}
