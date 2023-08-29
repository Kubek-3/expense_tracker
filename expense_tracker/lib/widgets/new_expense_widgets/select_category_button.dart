// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";
import 'package:expense_tracker/models/expense.dart';

class SelectCategoryButton extends StatelessWidget {
  SelectCategoryButton({required this.selectedCateogry, required this.onChanged, super.key});

  Category selectedCateogry;
  final Function(Category) onChanged;

  @override
  Widget build(context) {
    return DropdownButton(
      value: selectedCateogry,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        onChanged;
      },
    );
  }
}
