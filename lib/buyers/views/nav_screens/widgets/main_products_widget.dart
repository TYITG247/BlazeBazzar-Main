import 'package:blazebazzar/buyers/views/product_deatil/product_detail_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainProductsWidget extends StatefulWidget {
  final String? sortBy;
  const MainProductsWidget({super.key, this.sortBy});

  @override
  State<MainProductsWidget> createState() => _MainProductsWidgetState();
}

class _MainProductsWidgetState extends State<MainProductsWidget> {
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

        return GridView.builder(
          itemCount: snapshot.data!.docs.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 200 / 350),
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
                        height: 180,
                        width: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(productData['imageUrlList'][0]),
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
                      "₹ " + productData['productPrice'].toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 20, color: FlexColor.mandyRedLightPrimary),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
