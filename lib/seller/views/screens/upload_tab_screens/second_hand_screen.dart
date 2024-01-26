import 'package:flutter/material.dart';

class SecondHandScreen extends StatefulWidget {
  const SecondHandScreen({super.key});

  @override
  State<SecondHandScreen> createState() => _SecondHandScreenState();
}

class _SecondHandScreenState extends State<SecondHandScreen> {

  bool? _isSecondHand = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text(
            "Second Hand",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,

            ),
          ),
          value: _isSecondHand,
          onChanged: (value) {
            setState(() {
              _isSecondHand = value;
            });
          },
        ),
        if(_isSecondHand == true)
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: ""
                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
}
