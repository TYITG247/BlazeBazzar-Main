import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _cartProvider.getCartItem.length,
        itemBuilder: (context, index) {
          final cartData = _cartProvider.getCartItem.values.toList()[index];
          return Card(
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 120,
                      width: 120,
                      child: Image.network(
                        cartData.imageUrl[0],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartData.productName,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5,
                          ),
                        ),
                        Text(
                          "₹ " + cartData.price.toStringAsFixed(2),
                          style: TextStyle(
                            fontSize: 22,
                            color: FlexColor.mandyRedLightPrimary,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: null,
                          child: Text(
                            cartData.productSize,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 120,
                          decoration: BoxDecoration(
                            color: FlexColor.mandyRedLightPrimary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: cartData.quantity == 1
                                    ? null
                                    : () {
                                        _cartProvider.decrement(cartData);
                                      },
                                icon: Icon(
                                  CupertinoIcons.minus,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                cartData.quantity.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _cartProvider.increment(cartData);
                                },
                                icon: Icon(
                                  CupertinoIcons.plus,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text(
      //         "Your Shopping Cart is Empty",
      //         style: TextStyle(
      //           fontSize: 28,
      //           fontWeight: FontWeight.bold,
      //           letterSpacing: 2,
      //           color: Colors.grey.shade700,
      //         ),
      //         textAlign: TextAlign.center,
      //       ),
      //       Gap(15),
      //       Container(
      //         height: 40,
      //         width: MediaQuery.of(context).size.width - 40,
      //         decoration: BoxDecoration(
      //           color: FlexColor.mandyRedLightPrimary,
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: Center(
      //           child: Text(
      //             "Continue Shopping",
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontSize: 20,
      //               letterSpacing: 3,
      //             ),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
