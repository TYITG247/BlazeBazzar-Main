import 'package:blazebazzar/buyers/views/product_deatil/product_detail_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProducts extends StatefulWidget {
  final String categoryName;
  final String? sortBy;

  const HomeProducts({super.key, required this.categoryName, this.sortBy});

  @override
  State<HomeProducts> createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts> {
  bool? sortByPriceLowToHigh;
  @override
  Widget build(BuildContext context) {
    sortByPriceLowToHigh = (widget.sortBy != null)
        ? widget.sortBy == "low"
        ? true
        : false
        : null;
    setState(() {});
    print(sortByPriceLowToHigh);
    final Stream<QuerySnapshot> productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: widget.categoryName)
        .where('approved', isEqualTo: true)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LinearProgressIndicator();
        }

        List<Map<String, dynamic>> productList = snapshot.data!.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        if (widget.sortBy != null) {
          // Sorting the product list based on the chosen sort option
          if (sortByPriceLowToHigh == true) {
            productList
                .sort((a, b) => a['productPrice'].compareTo(b['productPrice']));
          } else {
            productList
                .sort((a, b) => b['productPrice'].compareTo(a['productPrice']));
          }
        }

        return Column(
          children: [
            SizedBox(
              height: 300,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final productData = productList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailScreen(
                              productData: productData,
                            );
                          },
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 200,
                              width: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      productData['imageUrlList'][0]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            productData['productName'],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "₹ ${productData['productPrice'].toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 20, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, _) => const SizedBox(width: 15),
                itemCount: productList.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
