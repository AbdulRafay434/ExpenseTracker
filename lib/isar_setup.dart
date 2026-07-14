import 'package:flutter_application_1/Models/Expense.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';


late final Isar isar;

Future <void> setupIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open(
    [ExpenseSchema],
    directory: dir.path,
  );
}