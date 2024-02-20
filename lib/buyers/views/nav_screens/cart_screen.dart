import 'package:blazebazzar/buyers/views/inner_screens/checkout_screen.dart';
import 'package:blazebazzar/buyers/views/main_screen.dart';
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
    Size screenSize = MediaQuery.of(context).size;
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              cartProvider.removeAllItem();
            },
            icon: Icon(
              CupertinoIcons.delete_solid,
              color: Colors.red.shade700,
            ),
          ),
        ],
      ),
      body: cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    cartProvider.getCartItem.values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: screenSize.height / 4,
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
                          padding: const EdgeInsets.only(top: 20, left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartData.productName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 5,
                                ),
                              ),
                              Text(
                                "₹${cartData.price.toStringAsFixed(2)}",
                                style: const TextStyle(
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
                              Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: FlexColor.mandyRedLightPrimary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: cartData.quantity == 1
                                              ? null
                                              : () {
                                                  cartProvider
                                                      .decrement(cartData);
                                                },
                                          icon: const Icon(
                                            CupertinoIcons.minus,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          cartData.quantity.toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: cartData.productQuantity ==
                                                  cartData.quantity
                                              ? null
                                              : () {
                                                  cartProvider
                                                      .increment(cartData);
                                                },
                                          icon: const Icon(
                                            CupertinoIcons.plus,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Gap(30),
                                  IconButton(
                                    onPressed: () {
                                      cartProvider.removeItem(
                                        cartData.productId,
                                      );
                                    },
                                    icon: const Icon(
                                      CupertinoIcons.cart_fill_badge_minus,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Shopping Cart is Empty",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      color: Colors.grey.shade700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(15),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const MainScreen();
                          },
                        ),
                      );
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                        color: FlexColor.mandyRedLightPrimary,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue Shopping",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const CheckoutScreen();
                      },
                    ),
                  );
                },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cartProvider.totalPrice == 0.00
                  ? Colors.grey
                  : FlexColor.mandyRedLightPrimary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Checkout",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4),
                ),
                const Gap(15),
                Text(
                  "₹${cartProvider.totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
