class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "image": image,
    };
  }
}
