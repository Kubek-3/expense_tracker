// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  AmountField({required this.amountControler, super.key});

  TextEditingController amountControler;

  @override
  Widget build(context) {
    return Expanded(
      child: TextField(
        controller: amountControler,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          suffixText: 'zł',
          label: Text('Amount'),
        ),
      ),
    );
  }
}
