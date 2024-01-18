import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: TextField(
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Search for Products",
              hintStyle: TextStyle(
                fontSize: 18,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(CupertinoIcons.search)),
        ),
      ),
    );
  }
}
