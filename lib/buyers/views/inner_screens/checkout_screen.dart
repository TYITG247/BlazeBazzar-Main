import 'package:blazebazzar/buyers/views/inner_screens/edit_profile.dart';
import 'package:blazebazzar/buyers/views/main_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool onlinePayment = true;
  String? paymentType;
  Widget _paymentTypeWidget() {
    return Switch(
      // This bool value toggles the switch.
      value: onlinePayment,
      activeColor: Colors.red,
      onChanged: (bool value) {
        if (onlinePayment == true) {
          paymentType = "Cash on Delivery";
        } else if (onlinePayment == false) {
          paymentType = "Online Payment";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Checkout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  "₹" + cartData.price.toStringAsFixed(2),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            bottomSheet: data['address'] == ''
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditProfileScreen(
                                userData: data,
                              );
                            },
                          ),
                        ).whenComplete(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Text(
                        "Enter Billing Address",
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Cash on Delivery"),
                              Gap(10),
                              _paymentTypeWidget(),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              // _cartProvider.getCartItem.forEach(
                              //   (key, item) {
                              //     double amount =
                              //         item.productQuantity * item.price;
                              //     Razorpay razorpay = Razorpay();
                              //     var options = {
                              //       'key': 'rzp_test_1DP5mmOlF5G5ag',
                              //       'amount': amount * 100,
                              //       'name': item.sellerId,
                              //       'description': item.productName,
                              //       'retry': {'enabled': true, 'max_count': 2},
                              //       'send_sms_hash': true,
                              //       'prefill': {
                              //         'contact': '8888888888',
                              //         'email': 'test@razorpay.com'
                              //       },
                              //       'external': {
                              //         'wallets': ['paytm']
                              //       }
                              //     };
                              //     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              //         handlePaymentErrorResponse);
                              //     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              //         handlePaymentSuccessResponse);
                              //     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              //         handleExternalWalletSelected);
                              //     razorpay.open(options);
                              //     EasyLoading.show(status: "Placing Order");
                              //     final orderId = const Uuid().v4();
                              //     _firestore
                              //         .collection('orders')
                              //         .doc(orderId)
                              //         .set(
                              //       {
                              //         'orderId': orderId,
                              //         'sellerId': item.sellerId,
                              //         'email': data['email'],
                              //         'phone': data['phone'],
                              //         'address': data['address'],
                              //         'buyerID': data['buyerID'],
                              //         'fullName': data['fullName'],
                              //         'productName': item.productName,
                              //         'productPrice': item.price,
                              //         'productId': item.productId,
                              //         'productImage': item.imageUrl,
                              //         'quantity': item.quantity,
                              //         'productSize': item.productSize,
                              //         'scheduleDate': item.scheduleDate,
                              //         'orderDate': DateTime.now(),
                              //         'paymentType': 'Cash on Delivery',
                              //         'accepted': false,
                              //       },
                              //     ).whenComplete(
                              //           () {
                              //         setState(() {
                              //           _cartProvider.getCartItem.clear();
                              //         });
                              //         EasyLoading.dismiss();
                              //         Navigator.pushReplacement(
                              //           context,
                              //           MaterialPageRoute(
                              //             builder: (context) {
                              //               return MainScreen();
                              //             },
                              //           ),
                              //         );
                              //       },
                              //     );
                              //   },
                              // );
                              _cartProvider.getCartItem.forEach(
                                (key, item) {
                                  EasyLoading.show(status: "Placing Order");
                                  final orderId = const Uuid().v4();
                                  _firestore
                                      .collection('orders')
                                      .doc(orderId)
                                      .set(
                                    {
                                      'orderId': orderId,
                                      'sellerId': item.sellerId,
                                      'email': data['email'],
                                      'phone': data['phone'],
                                      'address': data['address'],
                                      'buyerID': data['buyerID'],
                                      'fullName': data['fullName'],
                                      'productName': item.productName,
                                      'productPrice': item.price,
                                      'productId': item.productId,
                                      'productImage': item.imageUrl,
                                      'quantity': item.quantity,
                                      'productSize': item.productSize,
                                      'scheduleDate': item.scheduleDate,
                                      'orderDate': DateTime.now(),
                                      'paymentType': 'Cash on Delivery',
                                      'accepted': false,
                                    },
                                  ).whenComplete(
                                    () {
                                      setState(() {
                                        _cartProvider.getCartItem.clear();
                                      });
                                      EasyLoading.dismiss();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return MainScreen();
                                          },
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width - 100,
                              decoration: BoxDecoration(
                                color: FlexColor.mandyRedLightPrimary,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Center(
                                child: Text(
                                  "Place Order",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 4,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    print(response.data.toString());
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
