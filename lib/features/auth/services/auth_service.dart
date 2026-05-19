import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scrape_application/features/auth/models/user_model.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        uid: credential.user!.uid,
        name: name,
        email: email,
        image: "",
      );

      await firestore.collection('users').doc(user.uid).set(user.toMap());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "User already registered";
      }
      if (e.code == 'invalid-email') {
        return "Invalid email address";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    String uid = userCredential.user!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    if (!userDoc.exists) {
      throw "User data not found";
    }
  }
}
