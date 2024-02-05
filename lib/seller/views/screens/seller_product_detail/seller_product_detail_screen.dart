import 'package:blazebazzar/config/app_ui.dart';
import 'package:blazebazzar/utils/show_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SellerProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const SellerProductDetailScreen({
    super.key,
    required this.productData,
  });

  @override
  State<SellerProductDetailScreen> createState() =>
      _SellerProductDetailScreenState();
}

class _SellerProductDetailScreenState extends State<SellerProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  // final TextEditingController _productNameController = TextEditingController();
  // final TextEditingController _productNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _productNameController.text = widget.productData['productName'];
      _brandNameController.text = widget.productData['brandName'];
      _quantityController.text = widget.productData['quantity'].toString();
      _descriptionController.text = widget.productData['description'];
      _productPriceController.text =
          widget.productData['productPrice'].toString();
      _categoryController.text = widget.productData['category'];
    });
    super.initState();
  }

  double? productPrice;
  int? productQuantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    labelText: "Product Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _brandNameController,
                  decoration: InputDecoration(
                    labelText: "Brand Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value){
                    productQuantity = int.parse(value);
                  },
                  controller: _quantityController,
                  decoration: InputDecoration(
                    labelText: "Quantity",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLength: 800,
                  maxLines: 3,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value){
                    productPrice = double.parse(value);
                  },
                  controller: _productPriceController,
                  decoration: InputDecoration(
                    labelText: "Product Price",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: false,
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: "Category",
                  ),
                ),
              ),
              Gap(60),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () async {
            if(productPrice != null && productQuantity != null){
              EasyLoading.show();
              await _firestore
                  .collection('products')
                  .doc(widget.productData['productId'])
                  .update(
                {
                  'productName': _productNameController.text,
                  'brandName': _brandNameController.text,
                  'quantity': productQuantity,
                  'description': _descriptionController.text,
                  'productPrice': productPrice,
                  'category': _categoryController.text,
                },
              ).whenComplete((){
                EasyLoading.dismiss();
              });
            } else {
              showSnack(context, "Please Update the Quantity and Price");
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 100,
            decoration: BoxDecoration(
              color: FlexColor.mandyRedLightPrimary,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(
                "Update",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
