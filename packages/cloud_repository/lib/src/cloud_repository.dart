import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudRepository {
  Future<void> addNewUser(
      {required String email,
      required String name,
      required String uid}) async {
    final body = {
      'email': email,
      'forms': [],
      'name': name,
      'profileImg': '',
      'uid': uid
    };
    try {
      final result = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(body);
    } on FirebaseException catch (e) {
      log(e.message.toString());
    }
  }
}
