import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getUser() {
    return _auth.currentUser;
  }

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return "Success";
    } on FirebaseAuthException {
      return "Error";
    }
  }
  Future<String> register(File imageFile, String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final uploadTask = await _storage.ref('user_images/${user.user?.uid}').putFile(imageFile);
      final image = await uploadTask.ref.getDownloadURL();
      final date = DateTime.now();
      final newUser =
      {'id': "${user.user?.uid}", 'email': email, 'password': password, 'image': image, 'date': date.toLocal()};
      _firestore.collection('users').doc(user.user?.uid).set(newUser);
      return "Success";
    } on FirebaseAuthException {
      return "Error";
    }
  }

}