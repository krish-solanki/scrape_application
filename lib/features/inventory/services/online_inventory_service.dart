import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class OnlineInventoryService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<ScanModel>> getOnlineScan({required String userId}) async {
    final snapshot = await firestore
        .collection('scans')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs.map((e) => ScanModel.fromMap(e.data())).toList();
  }
}
