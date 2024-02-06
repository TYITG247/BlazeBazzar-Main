import 'package:blazebazzar/buyers/views/product_deatil/store_detail_screen.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _sellersStream =
        FirebaseFirestore.instance.collection('sellers').snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _sellersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final storeData = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return StoreDetailScreen(storeData: storeData,);
                      },
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      '${storeData['businessName'][0]}'.capitalize,
                    ),
                  ),
                  title: Text(
                    storeData['businessName'],
                  ),
                  subtitle: Text(
                    storeData['countryValue'],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
