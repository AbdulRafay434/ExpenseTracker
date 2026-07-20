

import 'package:flutter_application_1/Models/Expense.dart';
import 'package:flutter_application_1/Providers/Filter_criteria.dart';
import 'package:isar_community/isar.dart';

class ExpenseRepository {
  final Isar isar;
  ExpenseRepository(this.isar);

  Future<List<Expense>> getFilteredExpenses(ExpenseFilter filter) async {
  if (filter.category == null &&
      filter.startDate == null &&
      filter.endDate == null &&
      filter.minAmount == null &&
      filter.maxAmount == null) {
    return isar.expenses.where().findAll();
  }

  return await isar.expenses
    .filter()
    .optional(
      filter.category != null,
      (q) => q.categoryNameEqualTo(filter.category!.name)
    )
    .optional(
      filter.startDate != null,
      (q) => q.dateGreaterThan(filter.startDate!, include: true)
    )
    .optional(
      filter.endDate != null,
      (q) => q.dateLessThan(filter.endDate!, include: true)
    )
    .optional(
      filter.minAmount != null,
      (q) => q.amountGreaterThan(filter.minAmount!, include: true)
    )
    .optional(
      filter.maxAmount != null,
      (q) => q.amountLessThan(filter.maxAmount!, include: true)
    )
    .findAll();
}

  Future<void> addExpense(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  Future <List<Expense>> getallExpenses() async {
    return await isar.expenses.where().findAll();
  }

  Future<void> deleteExpenses(int id) async {
    await isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
  


}
}