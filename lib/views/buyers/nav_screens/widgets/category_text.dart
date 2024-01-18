import 'package:blazebazzar/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categorylabel = ["Food", "Vegetable", "Egg", "Tea"];

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categorylabel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: ActionChip(
                          onPressed: (){},
                          label: Text(
                            _categorylabel[index],
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
          ),
        ],
      ),
    );
  }
}
