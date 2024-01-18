import 'dart:io';
import 'package:blazebazzar/views/buyers/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAGo-BSooGos3S97TSy-uGg7UogBUKgFbA",
        appId: "1:848935089947:android:05d65d838622bff0d985be",
        messagingSenderId: "848935089947",
        projectId: "store1-1642c",
        storageBucket: "gs://store1-1642c.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: CustomLightTheme(),
      darkTheme: CustomDarkTheme(),
      themeMode: ThemeMode.system,
      home: const MainScreen(),
    );
  }
}
