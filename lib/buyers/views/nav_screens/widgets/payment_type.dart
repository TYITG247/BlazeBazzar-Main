import 'package:flutter/material.dart';

class PaymentTypeWidget extends StatefulWidget {

  @override
  State<PaymentTypeWidget> createState() => _PaymentTypeWidgetState();
}

class _PaymentTypeWidgetState extends State<PaymentTypeWidget> {
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Switch(
      // This bool value toggles the switch.
      value: light,
      activeColor: Colors.red,
      onChanged: (bool value) {
        // This is called when the user toggles the switch.
        setState(() {
          light = value;
        });
      },
    );
  }
}