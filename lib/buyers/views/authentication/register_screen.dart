import 'package:blazebazzar/buyers/controllers/authentication_controller.dart';
import 'package:blazebazzar/buyers/views/authentication/login_screen.dart';
import 'package:blazebazzar/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:blazebazzar/config/app_ui.dart';

class BuyerRegisterScreen extends StatefulWidget {
  @override
  State<BuyerRegisterScreen> createState() => _BuyerRegisterScreenState();
}

class _BuyerRegisterScreenState extends State<BuyerRegisterScreen> {
  bool _isSecurePassword = true;
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
  Widget togglePassword(){
    return IconButton(onPressed: (){
      setState(() {
        _isSecurePassword = !_isSecurePassword;

      });

    }, icon: _isSecurePassword ? Icon(Icons.visibility_off_rounded) : Icon(Icons.visibility_rounded),
      color:Colors.grey,);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: FlexColor.pinkM3LightPrimary,
            toolbarHeight: 200,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 50),
                        child: Text(
                          "Lets get Started, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          "Create to your account",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Gap(15),
                    ],
                  ),
                ),
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 8, right: 20, bottom: 8),
                      child: TextFormField(
                        onChanged: (value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
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
                        keyboardType: TextInputType.name,
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
                        keyboardType: TextInputType.phone,
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
                        obscureText: _isSecurePassword,
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
                          suffixIcon: togglePassword(),
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
        ],
      ),
    );
  }
}
