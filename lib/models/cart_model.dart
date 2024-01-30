import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartModel with ChangeNotifier {
  final String productName;
  final String productId;
  final List imageUrl;
  int quantity;
  final double price;
  final String sellerId;
  final String productSize;
  Timestamp scheduleDate;

  CartModel({
    required this.productName,
    required this.productId,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.sellerId,
    required this.productSize,
    required this.scheduleDate,
  });
  void increase(){
    quantity++;
  }
  void decrease(){
    quantity--;
  }
}