// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  TitleField({required this.titleControler, super.key});

  TextEditingController titleControler;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: titleControler,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );
  }
}
