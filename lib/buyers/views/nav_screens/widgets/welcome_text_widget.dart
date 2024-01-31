import 'package:flutter/cupertino.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top,),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Hey, What are you\nLooking For 👀?",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Icon(
            CupertinoIcons.shopping_cart,
            size: 34,
          )
        ],
      ),
    );
  }
}
