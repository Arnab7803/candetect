import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices {
  static saveUser(String firstName, lastName, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'firstName': firstName, 'lastName': lastName});
  }
}
