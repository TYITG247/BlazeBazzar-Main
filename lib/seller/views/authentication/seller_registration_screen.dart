import 'package:blazebazzar/seller/controllers/seller_register_controller.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gap/gap.dart';

class SellerRegistrationScreen extends StatefulWidget {
  const SellerRegistrationScreen({super.key});

  @override
  State<SellerRegistrationScreen> createState() =>
      _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SellerController _sellerController = SellerController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String businessName;
  late String email;
  late String phoneNumber;
  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String taxNumber;

  // Uint8List? _image;

  // selectGalleryImage() async {
  //   Uint8List? im = await _sellerController.pickStoreImage(ImageSource.gallery);
  //   setState(() {
  //     _image = im;
  //   });
  // }

  String? _taxStatus;

  List<String> _taxOptions = ['Yes', 'No'];

  _saveSellerDetails() async {
    EasyLoading.show();
    if (_formkey.currentState!.validate()) {
      await _sellerController.registerSeller(
        businessName,
        email,
        phoneNumber,
        countryValue,
        stateValue,
        cityValue,
        _taxStatus!,
        taxNumber,
      ).whenComplete((){
        EasyLoading.dismiss();
        setState(() {
          _formkey.currentState!.reset();
        });
      });
    } else {
      print("BAAAD");
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: FlexColor.pinkM3LightPrimary,
            toolbarHeight: 150,
            flexibleSpace: LayoutBuilder(builder: (context, constraints) {
              return FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        FlexColor.redLightPrimary,
                        FlexColor.mandyRedLightPrimary,
                      ],
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 50),
                        child: Text(
                          "Seller Account",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          "Create your account",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Business Name cannot be Empty";
                        } else {
                          return RegExp(r'^[a-zA-Z]+(?:\s+[a-zA-Z]+)*$')
                                  .hasMatch(value)
                              ? null
                              : "Enter a valid Name.";
                        }
                      },
                      onChanged: (value) {
                        businessName = value;
                      },
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: "Business Name",
                      ),
                    ),
                    Gap(10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email cannot be Empty";
                        } else {
                          return RegExp(
                                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                  .hasMatch(value)
                              ? null
                              : "Enter a valid Email.";
                        }
                      },
                      onChanged: (value) {
                        email = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "E-mail",
                      ),
                    ),
                    Gap(10),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Phone Number cannot be Empty";
                        } else {
                          return RegExp(r'^[0-9]{10}$').hasMatch(value)
                              ? null
                              : "Enter a valid Phone Number.";
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                      ),
                    ),
                    Gap(10),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: SelectState(
                        onCountryChanged: (value) {
                          setState(() {
                            countryValue = value;
                          });
                        },
                        onStateChanged: (value) {
                          setState(() {
                            stateValue = value;
                          });
                        },
                        onCityChanged: (value) {
                          setState(() {
                            cityValue = value;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tax Registered? ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            width: 100,
                            child: DropdownButtonFormField(
                                hint: const Text("Select"),
                                items:
                                    _taxOptions.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _taxStatus = value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    if (_taxStatus == "Yes")
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Tax Number cannot be Empty";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {
                          taxNumber = value;
                        },
                        decoration: InputDecoration(
                          labelText: "Tax Number",
                        ),
                      ),
                    Gap(20),
                    InkWell(
                      onTap: () {
                        _saveSellerDetails();
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: FlexColor.mandyRedLightPrimary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
