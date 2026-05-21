import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class DashboardService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserModel> getUserData() async {
    final uid = auth.currentUser!.uid;
    final snapshot = await firestore.collection('users').doc(uid).get();
    debugPrint(" Data is ${snapshot.data().toString()}");
    return UserModel.fromMap(snapshot.data()!);
  }

  Future<void> getScanDetails() async {
    final uid = auth.currentUser!.uid;
    final snapshot = await firestore
        .collection('scanItems')
        .where('userId', isEqualTo: uid)
        .get();

    // return ScanModel.fromMap(snapshot.docs());
  }

  Future<>
}
