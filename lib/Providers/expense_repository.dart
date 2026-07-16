

import 'package:flutter_application_1/Models/Expense.dart';
import 'package:isar_community/isar.dart';

class ExpenseRepository {
  final Isar isar;
  ExpenseRepository(this.isar);

  Future<void> addExpense(Expense expense) async {
    await isar.writeTxn(() async {
      await isar.expenses.put(expense);
    });
  }

  Future <List<Expense>> getallExpenses() async {
    return await isar.expenses.where().findAll();
  }

  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(() async {
      await isar.expenses.delete(id);
    });
  


}
}