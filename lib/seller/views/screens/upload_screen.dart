import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/product_provider.dart';
import 'package:blazebazzar/seller/views/screens/main_seller_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/attributes_tab_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/general_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/second_hand_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            elevation: 10,
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    'General',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                // Tab(
                //   child: Text(
                //     'Second Hand',
                //     textAlign: TextAlign.center,
                //     style: TextStyle(
                //       fontSize: 12,
                //     ),
                //   ),
                // ),
                Tab(
                  child: Text(
                    'Shipping Charge',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Attributes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Images',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GeneralScreen(),
              //SecondHandScreen(),
              ShippingScreen(),
              AttributesTabScreen(),
              ImagesTabScreen(),
            ],
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                EasyLoading.show(status: "Uploading Product");
                if (_formKey.currentState!.validate()) {
                  final productId = Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'product': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'imageUrlList':
                        _productProvider.productData['imageUrlList'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                  }).whenComplete(
                    () {
                      _productProvider.clearData();
                      _formKey.currentState!.reset();
                      EasyLoading.dismiss();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MainSellerScreen();
                          },
                        ),
                      );
                    },
                  );
                }
              },
              child: Text("Upload Product"),
            ),
          ),
        ),
      ),
    );
  }
}
