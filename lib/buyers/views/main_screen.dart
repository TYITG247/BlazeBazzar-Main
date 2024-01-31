import 'package:blazebazzar/buyers/views/nav_screens/account_screen.dart';
import 'package:blazebazzar/buyers/views/nav_screens/cart_screen.dart';
import 'package:blazebazzar/buyers/views/nav_screens/category_screen.dart';
import 'package:blazebazzar/buyers/views/nav_screens/home_screen.dart';
import 'package:blazebazzar/buyers/views/nav_screens/search_screen.dart';
import 'package:blazebazzar/buyers/views/nav_screens/store_screen.dart';
import 'package:flutter/cupertino.dart';
import '../../config/app_ui.dart';
import '../../config/app_theme.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoreScreen(),
    const CartScreen(),
    const SearchScreen(),
    const AccountScreen(),
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
            icon: Icon(CupertinoIcons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_search),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_outlined),
            label: "Store",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search_circle),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: "Account",
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
