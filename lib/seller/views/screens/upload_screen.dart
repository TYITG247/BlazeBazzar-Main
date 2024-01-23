import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow.shade900,
          elevation: 0,
          bottom: const TabBar(tabs: [
            Tab(
              child: Text('General'),
            ),

            Tab(
              child: Text('Shipping'),
            ),
            Tab(
              child: Text('Attributes'),
            ),
            Tab(
              child: Text('Images'),
            ),
          ]),
        ),

        body: const TabBarView(children: [
          Center(child: Text('General'),),
          Center(child: Text('Shipping'),),
          Center(child: Text('Attributes'),),
          Center(child: Text('Images'),),
        ],),
      ),
    );
  }
}
