
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Category.dart';
import 'package:isar_community/isar.dart';

part 'Expense.g.dart';

@Collection()
class Expense {
  Id id = Isar.autoIncrement;
  late String name;
  late String amount;
  late String date;
  late String categoryName;
  late int iconCodePoint;   
  late String iconFontFamily;
  late int colorVal;
  

  @ignore
  Color get color => Color(colorVal);
  @ignore
  IconData get icon {
    if (iconFontFamily.isEmpty) {
      // ignore: non_const_argument_for_const_parameter
      return IconData(iconCodePoint);
    }
    // ignore: non_const_argument_for_const_parameter
    return IconData(iconCodePoint, fontFamily: iconFontFamily);
  }
  @ignore
  Category get category => Category(name: categoryName, icon: icon, color: color);
  
  


  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.categoryName,
    required this.iconCodePoint,
    required this.colorVal,
    required this.iconFontFamily,
  });
}

