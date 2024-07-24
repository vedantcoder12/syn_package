import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sync_package/constants/custom_colors.dart';

class CustomForms {
  static Widget addForm(
      {required TextEditingController name,
      required TextEditingController designation,
      required VoidCallback onPressed
      
      }) {
    return Form(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: name,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: designation,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelText: 'Designation',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: CustomColors.submitButtonColor,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              minimumSize: const Size(double.infinity, 50),
              elevation: 0,
              shadowColor: Colors.transparent,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              visualDensity: VisualDensity.compact,
            ),
            child: const Center(child: Text('Submit')),
          ),
        ],
      ),
    ));
  }
}
