import 'package:blazebazzar/buyers/views/product_deatil/product_detail_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllProductsScreen extends StatelessWidget {
  final dynamic categoryData;

  const AllProductsScreen({
    super.key,
    required this.categoryData,
  });

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where(
          'category',
          isEqualTo: categoryData['categoryName'],
        )
        .where(
          'approved',
          isEqualTo: true,
        )
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          categoryData['categoryName'],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _productsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 200 / 300),
            itemBuilder: (context, index) {
              final productData = snapshot.data!.docs[index];
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
                              image:
                                  NetworkImage(productData['imageUrlList'][0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        productData['productName'],
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "₹ " + productData['productPrice'].toStringAsFixed(2),
                        style: TextStyle(
                            fontSize: 20,
                            color: FlexColor.mandyRedLightPrimary),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
