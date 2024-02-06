import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class SellerOrderScreen extends StatelessWidget {
  String formattedDate(date) {
    final outputDateFormat = DateFormat("DD-MM-yyyy");
    final outputDate = outputDateFormat.format(date);
    return outputDate;
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final Stream<QuerySnapshot> _ordersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('sellerId', isEqualTo: _auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 5,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _ordersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await _firestore
                              .collection('orders')
                              .doc(document['orderId'])
                              .update(
                            {
                              'accepted': true,
                            },
                          );
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.check,
                        label: 'Accept',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          await _firestore
                              .collection('orders')
                              .doc(document['orderId'])
                              .update(
                            {
                              'accepted': false,
                            },
                          );
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete_rounded,
                        label: 'Reject',
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: document['accepted'] == true
                              ? Icon(
                                  Icons.delivery_dining_rounded,
                                  color: FlexColor.mandyRedLightPrimary,
                                )
                              : Icon(
                                  Icons.access_time_filled_rounded,
                                  color: FlexColor.mandyRedLightPrimary,
                                ),
                        ),
                        title: document['accepted'] == true
                            ? Text(
                                "Accepted",
                                style: TextStyle(
                                  color: FlexColor.greenLightPrimary,
                                ),
                              )
                            : Text(
                                "Pending",
                                style: TextStyle(
                                  color: FlexColor.redLightPrimary,
                                ),
                              ),
                        trailing: Text(
                          "Amount " +
                              document['productPrice'].toStringAsFixed(2),
                        ),
                        subtitle: Text(
                          formattedDate(
                            document['orderDate'].toDate(),
                          ),
                          style: TextStyle(
                            color: FlexColor.blueLightPrimary,
                          ),
                        ),
                      ),
                      ExpansionTile(
                        title: Text("Order Details"),
                        subtitle: Text("View Orders"),
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
                                    Text(
                                      "Quantity",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      " : " + document['quantity'].toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                document['accepted'] == true
                                    ? Row(
                                        children: [
                                          Text("Schedule Delivery Date"),
                                          Text(
                                            " : " +
                                                formattedDate(
                                                  document['scheduleDate']
                                                      .toDate(),
                                                ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        "",
                                      ),
                                ListTile(
                                  title: Text(
                                    "Buyer Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document['fullName'],
                                      ),
                                      Text(
                                        document['email'],
                                      ),
                                      Text(
                                        document['address'],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
