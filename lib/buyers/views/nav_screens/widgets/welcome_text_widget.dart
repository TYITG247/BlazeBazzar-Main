import 'package:blazebazzar/buyers/views/nav_screens/cart_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

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
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
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
            child: Center(
              child:  badges.Badge(
                badgeContent: Text("${_cartProvider.getCartItem.length}", style: TextStyle(color: Colors.white),),
                badgeAnimation: badges.BadgeAnimation.rotation(
                  animationDuration: Duration(seconds: 1),
                  colorChangeAnimationDuration: Duration(seconds: 1),
                  loopAnimation: false,
                  curve: Curves.fastOutSlowIn,
                  colorChangeAnimationCurve: Curves.easeInCubic,
                ),
                showBadge: _cartProvider.getCartItem.length == 0 ? false : true,
                child: Icon(
                  CupertinoIcons.shopping_cart,
                  size: 34,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
