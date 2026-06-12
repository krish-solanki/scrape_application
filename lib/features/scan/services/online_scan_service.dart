import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class OnlineScanService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> onlineSaveScan(ScanModel scanModel) async {
    await firestore
        .collection('scans')
        .doc(scanModel.scanId)
        .set(scanModel.toMap());
  }
}
