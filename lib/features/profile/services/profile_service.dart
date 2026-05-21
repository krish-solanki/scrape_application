import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';

class ProfileService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel> getUserData() async {
    final uid = auth.currentUser!.uid;
    final snapshot = await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(snapshot.data()!);
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String image,
  }) async {
    final uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).update({
      "name": name,
      "phone": phone,
      "image": image,
    });
  }
}