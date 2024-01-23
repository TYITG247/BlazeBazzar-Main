import 'package:blazebazzar/seller/models/seller_user_model.dart';
import 'package:blazebazzar/seller/views/authentication/seller_registration_screen.dart';
import 'package:blazebazzar/seller/views/screens/main_seller_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _sellersStream =
      FirebaseFirestore.instance.collection('sellers');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: _sellersStream.doc(_auth.currentUser!.uid).snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if(!snapshot.data!.exists){
            return SellerRegistrationScreen();
          }

          SellerUserModel sellerUserModel = SellerUserModel.fromJson(
              snapshot.data!.data()! as Map<String, dynamic>);
          if(sellerUserModel.approved == true){
            return MainSellerScreen();
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 500,
                  width: MediaQuery.of(context).size.width - 100,
                  decoration: BoxDecoration(
                    color: FlexColor.mandyRedLightPrimaryContainer,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      sellerUserModel.businessName.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Gap(50),
                Text(
                  "Your Application has been sent to Admin\nAdmin Will get back to you soon...",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(50),
                CupertinoButton(
                  child: Text("Sign Out"),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
