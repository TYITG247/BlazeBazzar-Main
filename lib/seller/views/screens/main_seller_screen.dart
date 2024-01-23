import 'package:blazebazzar/config/app_theme.dart';
import 'package:blazebazzar/seller/views/screens/earning_screen.dart';
import 'package:blazebazzar/seller/views/screens/edit_product_screen.dart';
import 'package:blazebazzar/seller/views/screens/seller_account_screen.dart';
import 'package:blazebazzar/seller/views/screens/seller_order_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainSellerScreen extends StatefulWidget {
  const MainSellerScreen({super.key});

  @override
  State<MainSellerScreen> createState() => _MainSellerScreenState();
}

class _MainSellerScreenState extends State<MainSellerScreen> {

  int _pageIndex = 0;

  final List<Widget> _pages = [
    EarningScreen(),
    UploadScreen(),
    EditProductScreen(),
    SellerOrderScreen(),
    SellerAccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value){
          setState(() {
            _pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: CustomLightTheme().primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.currency_rupee_rounded),
            label: "Earning",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.plus),
            label: "Upload",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "Edit",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart_fill),
            label: "Orders",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.login_rounded),
          //   label: "LogOut",
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "Account",
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
