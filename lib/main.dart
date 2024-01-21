import 'dart:io';
import 'package:blazebazzar/views/buyers/authentication/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/app_ui.dart';
import 'config/app_theme.dart';

void main() async {
  runApp(
    SplashScreen(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          const MyApp(),
        );
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlazeBazzar',
      debugShowCheckedModeBanner: false,
      theme: CustomLightTheme(),
      darkTheme: CustomDarkTheme(),
      themeMode: ThemeMode.system,
      home: LoginScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreen({
    required Key key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) {
        _setup().then(
          (_) => widget.onInitializationComplete(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlazeBazzar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage("assets/images/play_store_512.png"),
              ),
              Gap(30),
              Container(
                height: 100,
                width: 170,
                child: const Text(
                  "BlazeBazzar",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: FlexColor.mandyRedLightPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
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
  }
}
