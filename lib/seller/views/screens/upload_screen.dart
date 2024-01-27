import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/product_provider.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/attributes_tab_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/general_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/second_hand_screen.dart';
import 'package:blazebazzar/seller/views/screens/upload_tab_screens/shipping_screen.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  print(_productProvider.productData['productName']);
                  print(_productProvider.productData['productPrice']);
                  print(_productProvider.productData['quantity']);
                  print(_productProvider.productData['category']);
                  print(_productProvider.productData['description']);
                  print(_productProvider.productData['imageUrlList']);
                }
              },
              child: Text("Save"),
            ),
          ),
        ),
      ),
    );
  }
}
