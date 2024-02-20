import 'package:blazebazzar/buyers/views/nav_screens/cart_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/cart_provider.dart';
import 'package:blazebazzar/utils/show_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _imageIndex = 0;
  String? _selectedSize;

  String formattedDate(date) {
    final outputDateFormat = DateFormat("dd-MM-yyyy");
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productData['productName']),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CartScreen();
                  },
                ),
              );
            },
            icon: Icon(
              CupertinoIcons.shopping_cart,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: PhotoView(
                    imageProvider: NetworkImage(
                      widget.productData['imageUrlList'][_imageIndex],
                    ),
                    backgroundDecoration: BoxDecoration(color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: widget.productData['imageUrlList'].length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _imageIndex = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(),
                              height: 60,
                              width: 60,
                              child: Image.network(
                                  widget.productData['imageUrlList'][index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Gap(15),
            Text(
              "₹ " + widget.productData['productPrice'].toStringAsFixed(2),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: FlexColor.mandyRedLightPrimary,
              ),
            ),
            Text(
              widget.productData['productName'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Product Decription",
                      style: TextStyle(
                        color: FlexColor.mandyRedLightPrimary,
                      ),
                    ),
                    Text(
                      "View more",
                      style: TextStyle(
                        color: FlexColor.mandyRedLightPrimary,
                      ),
                    ),
                  ],
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.productData['description'],
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade700),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "This product will shipping on",
                  style: TextStyle(
                    color: FlexColor.mandyRedLightPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  formattedDate(
                    widget.productData['scheduleDate'].toDate(),
                  ),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ExpansionTile(
                title: Text(
                  "Available Sizes",
                ),
                initiallyExpanded: true,
                children: [
                  Container(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: _selectedSize ==
                                    widget.productData['sizeList'][index]
                                ? BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        FlexColor.mandyRedLightPrimaryContainer,
                                  )
                                : null,
                            child: OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _selectedSize =
                                      widget.productData['sizeList'][index];
                                });
                                print(_selectedSize);
                              },
                              child: Text(
                                widget.productData['sizeList'][index],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Gap(80),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.getCartItem
                  .containsKey(widget.productData['productId'])
              ? null
              : () {
                  if (_selectedSize == null) {
                    showSnack(context, "Please select a Size");
                  } else {
                    _cartProvider.addProductToCart(
                      widget.productData['productName'],
                      widget.productData['productId'],
                      widget.productData['imageUrlList'],
                      1,
                      widget.productData['quantity'],
                      widget.productData['productPrice'].toDouble(),
                      widget.productData['sellerId'],
                      _selectedSize!,
                      widget.productData['scheduleDate'],
                    );
                    return showSnack(context,
                        "You Added ${widget.productData['productName']} To your Cart");
                  }
                },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: _cartProvider.getCartItem
                      .containsKey(widget.productData['productId'])
                  ? Colors.grey
                  : FlexColor.mandyRedLightPrimary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                  size: 35,
                ),
                Gap(15),
                _cartProvider.getCartItem
                        .containsKey(widget.productData['productId'])
                    ? const Text(
                        "In Cart",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      )
                    : const Text(
                        "Add To Cart",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 3,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
