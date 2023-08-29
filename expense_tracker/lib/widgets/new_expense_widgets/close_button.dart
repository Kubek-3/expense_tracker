import 'package:flutter/material.dart';

class Close extends StatelessWidget {
  const Close({super.key});
  
  @override
  Widget build(context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Close'),
    );
  }
}
