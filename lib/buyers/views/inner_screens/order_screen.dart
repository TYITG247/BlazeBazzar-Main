import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/utils/generateInvoice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  String formattedDate(date) {
    final outputDateFormat = DateFormat("dd-MM-yyyy");
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final Stream<QuerySnapshot> ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('buyerID', isEqualTo: auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 5,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 14,
                      child: document['accepted'] == true
                          ? const Icon(
                              Icons.delivery_dining_rounded,
                              color: FlexColor.mandyRedLightPrimary,
                            )
                          : const Icon(
                              Icons.access_time_filled_rounded,
                              color: FlexColor.mandyRedLightPrimary,
                            ),
                    ),
                    title: document['accepted'] == true
                        ? const Text(
                            "Accepted",
                            style: TextStyle(
                              color: FlexColor.greenLightPrimary,
                            ),
                          )
                        : const Text(
                            "Pending",
                            style: TextStyle(
                              color: FlexColor.redLightPrimary,
                            ),
                          ),
                    trailing: Text(
                      "Amount " + document['productPrice'].toStringAsFixed(2),
                    ),
                    subtitle: Text(
                      formattedDate(
                        document['orderDate'].toDate(),
                      ),
                      style: const TextStyle(
                        color: FlexColor.blueLightPrimary,
                      ),
                    ),
                  ),
                  ExpansionTile(
                    title: const Text("Order Details"),
                    subtitle: const Text("View Orders"),
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Image.network(
                            document['productImage'][0],
                          ),
                        ),
                        title: Text(
                          document['productName'],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Quantity",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  " : ${document['quantity']}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  document['paymentType'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            document['accepted'] == true
                                ? Row(
                                    children: [
                                      const Text("Schedule Delivery Date"),
                                      Text(
                                        " : ${formattedDate(
                                          document['scheduleDate'].toDate(),
                                        )}",
                                      ),
                                    ],
                                  )
                                : const Text(
                                    "",
                                  ),
                            ListTile(
                              title: const Text(
                                "Buyer Details",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    document['fullName'],
                                  ),
                                  Text(
                                    document['email'],
                                  ),
                                  Text(
                                    document['address'] ?? "",
                                  )
                                ],
                              ),
                            ),
                            MaterialButton(
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                generateInvoice(
                                  InvoiceData(
                                    buyerName: document['fullName'],
                                    items: [
                                      InvoiceItem(
                                        itemName: document['productName'],
                                        quantity: document['quantity'],
                                        price: document['productPrice'],
                                      )
                                    ],
                                    totalAmount: document['productPrice'],
                                  ),
                                );
                              },
                              child: const Text(
                                "Download Invoice",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
