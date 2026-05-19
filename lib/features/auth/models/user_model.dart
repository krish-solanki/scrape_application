class UserModel {
  final String uid;
  final String name;
  final String email;
  final String image;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'image': image,
    };
  }
}