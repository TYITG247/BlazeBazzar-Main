import 'package:blazebazzar/config/app_theme.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/views/buyers/nav_screens/widgets/home_products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryText extends StatefulWidget {
  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Category",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              return Container(
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final categoryData = snapshot.data!.docs[index];
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: ActionChip(
                              onPressed: () {
                                setState(() {
                                  _selectedCategory = categoryData['categoryName'];
                                });
                              },
                              label: Text(
                                categoryData['categoryName'],
                                style: TextStyle(
                                    color: CustomLightTheme().indicatorColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              );
            },
          ),
          if(_selectedCategory != null)
            HomeProducts(categoryName: _selectedCategory!),
        ],
      ),
    );
  }
}
