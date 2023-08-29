// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class DateSelecter extends StatelessWidget {
  DateSelecter({required this.selectedDate, required this.presenrDatePicker, super.key});

  DateTime? selectedDate;
  final Function() presenrDatePicker;

  @override
  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton.icon(
          label: Text(selectedDate == null
              ? 'No date selected'
              : formatter.format(selectedDate!)),
          icon: const Icon(Icons.calendar_month),
          onPressed: presenrDatePicker,
        )
      ],
    );
  }
}
