import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;
  const EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? address;
  //final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _fullNameController.text = widget.userData['fullName'];
      _emailController.text = widget.userData['email'];
      _phoneController.text = widget.userData['phone'];
      //_addressController.text = widget.userData['address'];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Enter Full Name"),
                controller: _fullNameController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Enter Email"),
                controller: _emailController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Enter Phone"),
                controller: _phoneController,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, top: 8, right: 20, bottom: 8),
              child: TextFormField(
                onChanged: (value){
                  address = value;
                },
                decoration: InputDecoration(labelText: "Enter Address"),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: "Updating");
            await _firestore
                .collection('buyers')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update(
              {
                'fullName': _fullNameController.text,
                'email': _emailController.text,
                'phone': _phoneController.text,
                'address': address
              },
            ).whenComplete(() {
              EasyLoading.dismiss();
              Navigator.pop(context);
            });
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
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
