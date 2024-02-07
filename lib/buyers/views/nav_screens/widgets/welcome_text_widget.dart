import 'package:blazebazzar/buyers/views/nav_screens/cart_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:flutter/cupertino.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hey, What are you\nLooking For 👀?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartScreen();
                  },
                ),
              );
            },
            child: Icon(
              CupertinoIcons.shopping_cart,
              size: 34,
            ),
          ),
        ],
      ),
    );
  }
}
