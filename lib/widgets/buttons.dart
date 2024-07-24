import 'package:flutter/material.dart';

class CustomButtons {
  static Widget customButton(
      {required String title, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      child: Text(title),
    );
  }

  static Widget addButton({required VoidCallback onPressed}) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: const Color.fromARGB(255, 8, 12, 243),
      foregroundColor: Colors.white,
      elevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      focusElevation: 0,
      disabledElevation: 0,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        color: Colors.white,
        size: 30,
        semanticLabel: 'Add',
        textDirection: TextDirection.ltr,
        shadows: <Shadow>[],
        weight: 100,
      ),
    );
  }
}
