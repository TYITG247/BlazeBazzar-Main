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
  final Razorpay _razorpay = Razorpay(); // Instance of Razorpay
  final razorPayKey = "rzp_test_mJAguCPXYxZrA5";
  final razorPaySecret = "GUU0i1hSIfe1bTTipYBcMaFg";
  bool codPayment = true;
  String? paymentType;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // To handle different event with previous functions
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Widget _paymentTypeWidget() {
    return Switch(
      // This bool value toggles the switch.
      value: codPayment,
      activeColor: Colors.red,
      onChanged: (bool value) {
        if (codPayment == false) {
          paymentType = "Cash on Delivery";
          codPayment = true;
        } else if (codPayment == true) {
          paymentType = "Online Payment";
          codPayment = false;
        }
        setState(() {});
        print(paymentType);
        print(codPayment);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
          snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Checkout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: ListView.builder(
              shrinkWrap: true,
              itemCount: cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                cartProvider.getCartItem.values.toList()[index];
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
                                  style: const TextStyle(
                                    fontSize: 22,
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
                child: const Text(
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
                        const Text("Cash on Delivery"),
                        const Gap(10),
                        _paymentTypeWidget(),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        cartProvider.getCartItem.forEach(
                              (key, item) {
                            EasyLoading.show(status: "Placing Order");

                            if (codPayment == false) {
                              var options = {
                                'key': razorPayKey,
                                'amount': item.price * 100,
                                'name': 'Blazebazzar',
                                'description': 'Description for order',
                                'timeout': 60,
                              };
                              _razorpay.open(options);
                              final orderId = const Uuid().v4();
                              firestore
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
                                  'paymentType': paymentType,
                                  'accepted': false,
                                },
                              ).whenComplete(
                                    () {
                                  setState(() {
                                    cartProvider.getCartItem.clear();
                                  });
                                  EasyLoading.dismiss();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MainScreen();
                                      },
                                    ),
                                  );
                                },
                              );
                            } else {
                              final orderId = const Uuid().v4();
                              firestore
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
                                  'paymentType': paymentType,
                                  'accepted': false,
                                },
                              ).whenComplete(
                                    () {
                                  setState(() {
                                    cartProvider.getCartItem.clear();
                                  });
                                  EasyLoading.dismiss();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MainScreen();
                                      },
                                    ),
                                  );
                                },
                              );
                            }
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
                        child: const Center(
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
