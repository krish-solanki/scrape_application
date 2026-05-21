class ScanModel {
  final String userId;
  final String scanId;
  final String name;
  final int quantity;
  final int weight;
  final int used;
  final String status;
  final int remains;
  final bool favourite;
  final String image;
  final DateTime date;
  final String scrapeType;

  ScanModel({
    required this.userId,
    required this.scanId,
    required this.name,
    required this.quantity,
    required this.weight,
    required this.used,
    required this.status,
    required this.remains,
    required this.favourite,
    required this.image,
    required this.date,
    required this.scrapeType,
  });

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      userId: map['userId'] ?? '',
      scanId: map['uid'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? '',
      weight: map['weight'] ?? '',
      used: map['used'] ?? '',
      status: map['status'] ?? '',
      remains: map['remains'] ?? '',
      favourite: map['favourite'] ?? '',
      image: map['image'] ?? '',
      date: map['date'] ?? '',
      scrapeType: map['scrapeType'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": scanId,
      "name": name,
      "email": quantity,
      "phone": weight,
      "used": used,
      "status": status,
      "remains": remains,
      "favourite": favourite,
      "image": image,
      "date": date,
      "scrapeType": scrapeType,
    };
  }
}
