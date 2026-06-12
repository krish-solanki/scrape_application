import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class DashboardService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  static const String boxName = 'scan_box';

  Future<List<ScanModel>> getOnlineScans({required String userId}) async {
    final snapshot = await firestore
        .collection('scans')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .limit(5)
        .get();

    return snapshot.docs.map((e) => ScanModel.fromMap(e.data())).toList();
  }

  Future<UserModel?> getUserData() async {
    final currentUser = auth.currentUser;

    if (currentUser == null) {
      return null;
    }

    final snapshot = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    debugPrint("User Data : ${snapshot.data()}");

    return UserModel.fromMap(snapshot.data()!);
  }

  Future<List<ScanModel>> getLocalScans() async {
    final box = await Hive.openBox(boxName);
    final scans = box.values
        .map((e) => ScanModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    scans.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return scans.take(5).toList();
  }

  Future<void> deleteScan(int index) async {
    final box = await Hive.openBox(boxName);

    await box.deleteAt(index);
  }

  Future<void> clearAllScans() async {
    final box = await Hive.openBox(boxName);

    await box.clear();
  }
}
