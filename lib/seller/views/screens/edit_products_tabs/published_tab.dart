import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/seller/views/screens/seller_product_detail/seller_product_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PublishedTab extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> _sellerProductsStream = FirebaseFirestore
        .instance
        .collection('products')
        .where('sellerId', isEqualTo: _auth.currentUser!.uid)
        .where('approved', isEqualTo: true)
        .snapshots();
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _sellerProductsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.data!.docs.length == 0
              ? Center(
                  child: Text("There is no Products to UnPublish"),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final sellerProductsData = snapshot.data!.docs[index];
                      return Slidable(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SellerProductDetailScreen(
                                    productData: sellerProductsData,
                                  );
                                },
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(
                                    sellerProductsData['imageUrlList'][0],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sellerProductsData['productName'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "₹" +
                                          sellerProductsData['productPrice']
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: FlexColor.mandyRedLightPrimary,
                                        letterSpacing: 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        key: const ValueKey(0),
                        startActionPane: ActionPane(
                          motion: DrawerMotion(),
                          children: [
                            SlidableAction(
                              flex: 2,
                              onPressed: (context) async {
                                await _firestore
                                    .collection('products')
                                    .doc(sellerProductsData['productId'])
                                    .update(
                                  {
                                    'approved': false,
                                  },
                                );
                              },
                              backgroundColor: Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.block_rounded,
                              label: "Decline",
                            ),
                            SlidableAction(
                              flex: 2,
                              onPressed: (context) async {
                                await _firestore
                                    .collection('products')
                                    .doc(sellerProductsData['productId'])
                                    .delete();
                              },
                              backgroundColor: Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete_rounded,
                              label: 'Delete',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
