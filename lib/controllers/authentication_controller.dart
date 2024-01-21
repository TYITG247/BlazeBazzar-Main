import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> registerUsers(
    String email,
    String fullName,
    String phoneNumber,
    String password,
  ) async {
    String res = "Some error occurred";
    try {
      if (email.isNotEmpty &&
          fullName.isNotEmpty &&
          phoneNumber.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await _firestore.collection("buyers").doc(cred.user!.uid).set({
          'email': email,
          'fullName': fullName,
          'phone': [phoneNumber],
          'buyerID': cred.user!.uid,
          'address': []
        });
        res = "Successful";
      } else {
        res = "Please Fields must not be empty";
      }
    } catch (e) {}
    return res;
  }
}
