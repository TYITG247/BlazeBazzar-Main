import 'package:blazebazzar/seller/views/screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class SellerAuthenticationScreen extends StatefulWidget {
  const SellerAuthenticationScreen({super.key});

  @override
  State<SellerAuthenticationScreen> createState() =>
      _SellerAuthenticationScreenState();
}

class _SellerAuthenticationScreenState
    extends State<SellerAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
            ],
          );
        }
        return LandingScreen();
      },
    );
  }
}
