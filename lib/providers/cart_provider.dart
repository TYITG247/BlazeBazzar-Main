import 'package:blazebazzar/models/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _cartItems = {};
  Map<String, CartModel> get getCartItem {
    return _cartItems;
  }

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
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
        productId,
        () => CartModel(
            productName: productName,
            productId: productId,
            imageUrl: imageUrl,
            quantity: quantity,
            price: price,
            sellerId: sellerId,
            productSize: productSize,
            scheduleDate: scheduleDate),
      );
      notifyListeners();
    }
  }
  void increment(CartModel cartModel){
    cartModel.increase();
    notifyListeners();
  }
  void decrement(CartModel cartModel){
    cartModel.decrease();
    notifyListeners();
  }
}
