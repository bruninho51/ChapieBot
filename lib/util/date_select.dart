import 'package:flutter/material.dart';

Future<Null> dateSelect({context, onSelect, initialDate}) async { 
  final DateTime picked = await showDatePicker(
    context: context, 
    initialDate: initialDate, 
    firstDate: DateTime.now(),
    lastDate: DateTime(2101),
  );
  onSelect(picked);
}