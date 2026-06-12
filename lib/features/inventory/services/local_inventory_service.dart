import 'package:hive/hive.dart';
import 'package:scrape_application/features/scan/models/scan_model.dart';

class LocalInventoryService {
  static const String boxName = 'scan_box';

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

  Future<void> clearAllScans() async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }
}
