import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainSellerScreen extends StatelessWidget {
  const MainSellerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("Sign Out"),
          onPressed: (){
            FirebaseAuth.instance.signOut();
          },
        ),
      ),
    );
  }
}
