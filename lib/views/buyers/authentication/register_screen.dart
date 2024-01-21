import 'package:blazebazzar/controllers/authentication_controller.dart';
import 'package:blazebazzar/utils/show_snackbar.dart';
import 'package:blazebazzar/views/buyers/authentication/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:blazebazzar/config/app_ui.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthenticationController _authenticationController =
      AuthenticationController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String email;

  late String fullName;

  late String phoneNumber;

  late String password;

  bool _isLoading = false;

  _registerUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formkey.currentState!.validate()) {
      await _authenticationController
          .registerUsers(email, fullName, phoneNumber, password)
          .whenComplete(() {
        setState(() {
          _formkey.currentState!.reset();
          _isLoading = false;
        });
      });
      return showSnack(
          context, "Congratulations, Account Successfully Created");
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnack(context, "Fields cannot be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Gap(50),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Create Customer Account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: FlexColor.mandyRedLightPrimary,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 8, right: 20, bottom: 8),
                  child: TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
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
                    decoration: InputDecoration(
                      labelText: "Enter Email",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 8, right: 20, bottom: 8),
                  child: TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name cannot be Empty";
                      } else {
                        return RegExp(r'^[a-zA-Z]+(?:\s+[a-zA-Z]+)*$')
                                .hasMatch(value)
                            ? null
                            : "Enter a valid Name.";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Full Name",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 8, right: 20, bottom: 8),
                  child: TextFormField(
                    onChanged: (value) {
                      phoneNumber = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone Number cannot be Empty";
                      } else {
                        return RegExp(r'^[0-9]{10}$').hasMatch(value)
                            ? null
                            : "Enter a valid Phone Number.";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Enter Phone Number",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 8, right: 20, bottom: 8),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password cannot be Empty";
                      } else {
                        return RegExp(
                                    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$')
                                .hasMatch(value)
                            ? null
                            : "Enter a valid Password.";
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                ),
                Gap(20),
                GestureDetector(
                  onTap: () {
                    _registerUser();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlexColor.mandyRedLightPrimary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?,",
                      style: TextStyle(fontSize: 16),
                    ),
                    CupertinoButton(
                      child: Text("Log In"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
