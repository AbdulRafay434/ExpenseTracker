import 'package:flutter_application_1/Models/Expense.dart';
import 'package:flutter_application_1/Providers/expense_repository.dart';
import 'package:flutter_application_1/isar_setup.dart';
import 'package:riverpod/legacy.dart';

class Expenseprovider extends StateNotifier<List<Expense>>{
  final ExpenseRepository repository;


  Expenseprovider(this.repository) : super([]){
    loadExpense();
  }

  Future<void> loadExpense() async {
    state = await repository.getallExpenses();
  }

  Future<void> add(Expense expense) async{

    await repository.addExpense(expense);
    state = [...state, expense];

  }
  Future<void> deleteHabit(int id) async {
    await repository.deleteHabit(id);
    state = state.where((h) => h.id != id).toList();
  }


}

final expenselistProvider = StateNotifierProvider<Expenseprovider, List<Expense>>((ref){
  return Expenseprovider(ExpenseRepository(isar));
});