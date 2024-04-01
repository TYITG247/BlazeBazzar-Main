import 'package:blazebazzar/buyers/views/nav_screens/category_screen.dart';
import 'package:blazebazzar/config/app_theme.dart';
import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/buyers/views/nav_screens/widgets/home_products.dart';
import 'package:blazebazzar/buyers/views/nav_screens/widgets/main_products_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatefulWidget {
  const CategoryText({super.key});

  @override
  State<CategoryText> createState() => _CategoryTextState();
}

class _CategoryTextState extends State<CategoryText> {
  String? _selectedCategory;
  Map<String, dynamic>? selectedSorting;
  List<Map<String, dynamic>> sortingOptions = [
    {
      "text": "Price: Low to High",
      "value": "low",
    },
    {
      "text": "Price: High to Low",
      "value": "high",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream =
    FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading");
              }
              return SizedBox(
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
                              backgroundColor: _selectedCategory ==
                                  categoryData['categoryName']
                                  ? Colors.red
                                  : Colors.transparent,
                              onPressed: () {
                                setState(() {
                                  _selectedCategory =
                                  categoryData['categoryName'];
                                });
                              },
                              label: Text(
                                categoryData['categoryName'],
                                style: TextStyle(
                                    color: _selectedCategory ==
                                        categoryData['categoryName']
                                        ? Colors.white
                                        : CustomLightTheme().indicatorColor),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const CategoryScreen();
                            }));
                      },
                      icon: const Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ],
                ),
              );
            },
          ),
          // sort by
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: DropdownButton<Map<String, dynamic>>(
                hint: const Text("Sort by: Price"),
                value: selectedSorting,
                onChanged: (Map<String, dynamic>? newValue) {
                  setState(() {
                    selectedSorting = newValue;
                  });
                },
                items: sortingOptions
                    .map<DropdownMenuItem<Map<String, dynamic>>>((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e["text"],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          if (_selectedCategory == null)
            MainProductsWidget(
              sortBy:
              selectedSorting == null ? null : selectedSorting!['value'],
            ),
          if (_selectedCategory != null)
            HomeProducts(
              categoryName: _selectedCategory!,
              sortBy:
              selectedSorting == null ? null : selectedSorting!['value'],
            ),
        ],
      ),
    );
  }
}
