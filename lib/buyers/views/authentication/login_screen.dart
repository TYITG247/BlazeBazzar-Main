import 'package:blazebazzar/buyers/controllers/authentication_controller.dart';
import 'package:blazebazzar/buyers/views/authentication/register_screen.dart';
import 'package:blazebazzar/buyers/views/main_screen.dart';
import 'package:blazebazzar/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:blazebazzar/config/app_ui.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticationController _authenticationController =
      AuthenticationController();

  late String email;
  late String password;

  bool _isLoading = false;
  bool _isSecurePassword = true;

  _loginUser() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = await _authenticationController.loginUsers(email, password);
      if (res == "Successful") {
        return showSnack(context, "Logged In Successfully") &
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return MainScreen();
                },
              ),
            );
      } else {
        setState(() {
          _isLoading = false;
        });
        return showSnack(context, res);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, "Fields cannot be Empty");
    }
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility_off_rounded)
          : const Icon(Icons.visibility_rounded),
      color: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: FlexColor.pinkM3LightPrimary,
            toolbarHeight: screenSize.height / 3,
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
                          "Welcome Back, ",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          "LogIn to your account",
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
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 8, right: 20, bottom: 8),
                      child: TextFormField(
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
                        decoration: const InputDecoration(
                          labelText: "Enter E-mail Address",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, top: 8, right: 20, bottom: 8),
                      child: TextFormField(
                        obscureText: _isSecurePassword,
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
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: togglePassword(),
                          labelText: "Enter Password",
                        ),
                      ),
                    ),
                    const Gap(20),
                    InkWell(
                      onTap: () {
                        _loginUser();
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
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Log In",
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
                        const Text(
                          "Need an account?,",
                          style: TextStyle(fontSize: 16),
                        ),
                        CupertinoButton(
                          child: Text("Register"),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return BuyerRegisterScreen();
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
