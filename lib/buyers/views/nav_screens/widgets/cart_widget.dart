import 'package:blazebazzar/buyers/views/nav_screens/cart_screen.dart';
import 'package:blazebazzar/providers/cart_provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const CartScreen();
            },
          ),
        );
      },
      child: Center(
        child: badges.Badge(
          badgeContent: Text(
            "${cartProvider.getCartItem.length}",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          badgeAnimation: const badges.BadgeAnimation.rotation(
            animationDuration: Duration(seconds: 1),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: false,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          showBadge: cartProvider.getCartItem.isEmpty ? false : true,
          child: const Icon(
            CupertinoIcons.shopping_cart,
            size: 34,
          ),
        ),
      ),
    );
  }
}
