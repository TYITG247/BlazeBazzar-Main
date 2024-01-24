import 'package:blazebazzar/config/app_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Enter Product Name"),
              ),
              Gap(15),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Enter Product Price"),
              ),
              Gap(15),
              TextFormField(
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
                onChanged: (value) {},
              ),
              Gap(15),
              TextFormField(
                maxLines: 5,
                maxLength: 800,
                decoration: InputDecoration(
                  labelText: "Enter Product Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Gap(15),
              Row(
                children: [
                  CupertinoButton(
                    child: Text("Schedule"),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(5000),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
