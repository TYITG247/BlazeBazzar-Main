import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/connector_screen/switch_screen.dart';
import 'package:blazebazzar/seller/views/authentication/seller_authentication_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    CollectionReference users = FirebaseFirestore.instance.collection('sellers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(_auth.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 1,
              title: Text(
                "Profile",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Gap(25),
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: FlexColor.mandyRedLightPrimaryContainer,
                      child: Center(
                        child: Text(
                          '${data['businessName'][0]}'.capitalize,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 54,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  Text(
                    data['businessName'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data['email'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
                  ),
                  Gap(10),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return EditProfileScreen(userData: data,);
                  //         },
                  //       ),
                  //     );
                  //   },
                  //   child: Container(
                  //     height: 40,
                  //     width: MediaQuery.of(context).size.width - 300,
                  //     decoration: BoxDecoration(
                  //       color: FlexColor.mandyRedLightPrimaryContainer,
                  //       borderRadius: BorderRadius.circular(20),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         "Edit Profile",
                  //         style: TextStyle(color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Gap(15),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Gap(15),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.phone_solid),
                    title: Text(
                      "Phone",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.cart_fill),
                    title: Text(
                      "Cart",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(CupertinoIcons.doc_text_fill),
                    title: Text(
                      "Orders",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      await _auth.signOut().whenComplete(
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SwitchScreen();
                              },
                            ),
                          );
                        },
                      );
                    },
                    leading: Icon(Icons.logout_rounded),
                    title: Text(
                      "LogOut",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
