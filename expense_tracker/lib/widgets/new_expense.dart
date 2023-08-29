import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/new_expense_widgets/amount_field.dart';
import 'package:expense_tracker/widgets/new_expense_widgets/title_field.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense_widgets/save_button.dart';
import 'package:expense_tracker/widgets/new_expense_widgets/select_category_button.dart';
import 'package:expense_tracker/widgets/new_expense_widgets/close_button.dart';
import 'package:expense_tracker/widgets/new_expense_widgets/date_selecter.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCateogry = Category.leisure;

  void _presenrDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and cateogry was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and cateogry was entered'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountControler.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleControler.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleControler.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCateogry,
      ),
    );
    Navigator.pop(context);
  }

  void _onChanged(value) {
    {
      setState(() {
        if (value == null) {
          return;
        }
        _selectedCateogry = value;
      });
    }
  }

  @override
  void dispose() {
    _titleControler.dispose();
    _amountControler.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: TitleField(titleControler: _titleControler)),
                      const SizedBox(width: 24),
                      AmountField(amountControler: _amountControler),
                    ],
                  )
                else
                  TitleField(titleControler: _titleControler),
                if (width >= 600)
                  Row(
                    children: [
                      SelectCategoryButton(
                          selectedCateogry: _selectedCateogry,
                          onChanged: _onChanged),
                      const SizedBox(width: 24),
                      Expanded(
                        child: DateSelecter(
                          selectedDate: _selectedDate,
                          presenrDatePicker: _presenrDatePicker,
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      AmountField(amountControler: _amountControler),
                      const SizedBox(width: 20),
                      DateSelecter(
                        selectedDate: _selectedDate,
                        presenrDatePicker: _presenrDatePicker,
                      ),
                    ],
                  ),
                const SizedBox(height: 16),
                if (width >= 600)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Close(),
                      SaveButtons(submitExpenseData: _submitExpenseData),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SelectCategoryButton(
                        selectedCateogry: _selectedCateogry,
                        onChanged: _onChanged,
                      ),
                      const Spacer(),
                      const Close(),
                      SaveButtons(submitExpenseData: _submitExpenseData),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
