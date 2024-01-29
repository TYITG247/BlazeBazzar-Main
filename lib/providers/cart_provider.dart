import 'package:blazebazzar/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItem {
    return _cartItems;
  }

  // final String? productName;
  // final String? productId;
  // final List? imageUrl;
  // final int? quantity;
  // final double? price;
  // final String? sellerId;
  // final String? productSize;
  // Timestamp scheduleDate;

  void addProductToCart(
    String productName,
    String productId,
    List imageUrl,
    int quantity,
    double price,
    String sellerId,
    String productSize,
    Timestamp scheduleDate,
  ) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
        productId,
        (exitingCart) => CartModel(
          productName: exitingCart.productName,
          productId: exitingCart.productId,
          imageUrl: exitingCart.imageUrl,
          quantity: exitingCart.quantity + 1,
          price: exitingCart.price,
          sellerId: exitingCart.sellerId,
          productSize: exitingCart.productSize,
          scheduleDate: exitingCart.scheduleDate,
        ),
      );
    }
  }
}
