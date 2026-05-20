import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';

class DashboardService {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel> getUserData() async {
    final uid = auth.currentUser!.uid;
    final snapshot = await firestore.collection('users').doc(uid).get();
    return UserModel.fromMap(snapshot.data()!);
  }
}