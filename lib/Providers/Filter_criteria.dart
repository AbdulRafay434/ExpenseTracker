import 'package:flutter_application_1/Models/Category.dart';

class ExpenseFilter {
  final Category? category;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? minAmount;
  final int? maxAmount;

  const ExpenseFilter({
    this.category,
    this.startDate,
    this.endDate,
    this.minAmount,
    this.maxAmount,
  });

}