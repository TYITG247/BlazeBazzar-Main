import 'package:blazebazzar/buyers/views/nav_screens/widgets/cart_widget.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:flutter/cupertino.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({
    super.key,
  });

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hey, What are you\nLooking For 👀?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          CartWidget()
        ],
      ),
    );
  }
}
