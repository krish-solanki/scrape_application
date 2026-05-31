class ScanModel {
  final String userId;
  final String scanId;
  final String name;
  final String scrapType;
  final double confidence;
  final double weight;
  final String unit;
  final bool isFavourite;
  final String imageUrl;
  final double estimatedPrice;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  ScanModel({
    required this.userId,
    required this.scanId,
    required this.name,
    required this.scrapType,
    required this.confidence,
    required this.weight,
    required this.unit,
    required this.isFavourite,
    required this.imageUrl,
    required this.estimatedPrice,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScanModel.fromMap(Map<String, dynamic> map) {
    return ScanModel(
      userId: map['userId'] ?? '',
      scanId: map['scanId'] ?? '',
      name: map['name'] ?? '',
      scrapType: map['scrapType'] ?? '',
      confidence: (map['confidence'] ?? 0).toDouble(),
      weight: (map['weight'] ?? 0).toDouble(),
      unit: map['unit'] ?? 'kg',
      isFavourite: map['isFavourite'] ?? false,
      imageUrl: map['imageUrl'] ?? '',
      estimatedPrice: (map['estimatedPrice'] ?? 0).toDouble(),
      description: map['description'] ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.parse(map['createdAt'])
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.parse(map['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'scanId': scanId,
      'name': name,
      'scrapType': scrapType,
      'confidence': confidence,
      'weight': weight,
      'unit': unit,
      'isFavourite': isFavourite,
      'imageUrl': imageUrl,
      'estimatedPrice': estimatedPrice,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
