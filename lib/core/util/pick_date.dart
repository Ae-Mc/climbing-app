import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

Future<DateTime?> pickDate(
  BuildContext context,
  TextEditingController dateInputController,
) async {
  final date = await showDatePicker(
    context: context,
    initialDate: dateInputController.text == ''
        ? DateTime.now()
        : GetIt.I<DateFormat>().parse(dateInputController.text),
    firstDate: DateTime(2021, 1, 1),
    lastDate: DateTime(3000, 1, 1),
  );
  if (date != null) {
    dateInputController.text = GetIt.I<DateFormat>().format(date);
  }
  return date;
}
