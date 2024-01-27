import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/providers/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<String> _categoryList = [];

  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  String formattedDate(date) {
    final outputDateFormat = DateFormat('dd-MM-yyyy');
    final outPutDate = outputDateFormat.format(date);
    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(productName: value);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Product Name";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(labelText: "Enter Product Name"),
              ),
              Gap(15),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(
                      productPrice: double.parse(value));
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Product Price";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Enter Product Price"),
              ),
              Gap(15),
              TextFormField(
                onChanged: (value) {
                  _productProvider.getFormData(quantity: int.parse(value));
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Product Quantity";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Enter Product Quantity"),
              ),
              Gap(15),
              DropdownButtonFormField(
                hint: Text("Select Category"),
                items: _categoryList.map<DropdownMenuItem<String>>(
                  (e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _productProvider.getFormData(category: value);
                  });
                },
              ),
              Gap(15),
              TextFormField(
                maxLines: 5,
                maxLength: 800,
                onChanged: (value) {
                  _productProvider.getFormData(description: value);
                },
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Product Description";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Enter Product Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CupertinoButton(
                    child: Text("Schedule"),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(5000),
                      ).then((value) {
                        setState(() {
                          _productProvider.getFormData(scheduleDate: value);
                        });
                      });
                    },
                  ),
                  if (_productProvider.productData['scheduleDate'] != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(":"),
                    ),
                  if (_productProvider.productData['scheduleDate'] != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formattedDate(
                          _productProvider.productData['scheduleDate'],
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
