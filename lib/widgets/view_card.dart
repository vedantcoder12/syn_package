import 'package:flutter/material.dart';
import 'package:sync_package/constants/custom_colors.dart';

class CustomCards {
  static Widget viewCard({
    required String name,
    required String desg,
    required VoidCallback onDelete,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      height: 100,
      width: 220,
      decoration: BoxDecoration(
        color: CustomColors.appBarColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CustomColors.primaryFontColor),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.delete, color: CustomColors.primaryFontColor),
              onPressed: onDelete,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: CustomColors.appBarFontColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  desg,
                  style: TextStyle(
                      color: CustomColors.primaryFontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
