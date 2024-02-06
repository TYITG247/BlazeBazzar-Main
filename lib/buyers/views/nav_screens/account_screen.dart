import 'package:blazebazzar/buyers/views/authentication/login_screen.dart';
import 'package:blazebazzar/buyers/views/inner_screens/edit_profile.dart';
import 'package:blazebazzar/buyers/views/inner_screens/order_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return _auth.currentUser == null
        ? Scaffold(
            appBar: AppBar(
              elevation: 5,
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
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                  ),
                  Gap(25),
                  Text(
                    'Login To Access Profile',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(20),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 100,
                      decoration: BoxDecoration(
                        color: FlexColor.mandyRedLightPrimary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          "Login Account",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                ],
              ),
            ),
          )
        : FutureBuilder<DocumentSnapshot>(
            future: users.doc(_auth.currentUser!.uid).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                            backgroundColor:
                                FlexColor.mandyRedLightPrimaryContainer,
                            child: Center(
                              child: Text(
                                '${data['fullName'][0]}'.capitalize,
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
                          data['fullName'],
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data['email'],
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w300),
                        ),
                        Gap(10),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditProfileScreen(
                                    userData: data,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 300,
                            decoration: BoxDecoration(
                              color: FlexColor.mandyRedLightPrimaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Gap(15),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return OrderScreen();
                                },
                              ),
                            );
                          },
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
                                      return LoginScreen();
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
