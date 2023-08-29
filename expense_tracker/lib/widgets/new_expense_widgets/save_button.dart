import 'package:flutter/material.dart';

class SaveButtons extends StatelessWidget {
  const SaveButtons({required this.submitExpenseData, super.key});

  final Function() submitExpenseData;

  @override
  Widget build(context) {
    return 
    ElevatedButton(
      onPressed: submitExpenseData,
      child: const Text('Save expense'),
    );
  }
}
