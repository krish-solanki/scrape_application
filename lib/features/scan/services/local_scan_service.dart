import 'package:hive/hive.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class LocalScanService {
  static const String boxName = 'scan_box';

  Future<void> localSaveScan(ScanModel scanModel) async {
    final box = await Hive.openBox(boxName);
    await box.add(scanModel.toMap());
  }

  Future<List<ScanModel>> getLocalScans() async {
    final box = await Hive.openBox(boxName);

    return box.values
        .map((e) => ScanModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> deleteScan(int index) async {
    final box = await Hive.openBox(boxName);
    await box.deleteAt(index);
  }

  Future<void> clearAll() async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
