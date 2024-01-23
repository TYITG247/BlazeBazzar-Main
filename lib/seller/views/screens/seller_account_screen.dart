import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SellerAccountScreen extends StatefulWidget {
  const SellerAccountScreen({super.key});

  @override
  State<SellerAccountScreen> createState() => _SellerAccountScreenState();
}

class _SellerAccountScreenState extends State<SellerAccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () async {
              await _auth.signOut();
            },
            child: Text("LogOut"),
          ),
        ],
      ),
    );
  }
}
