
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/Category.dart';
import 'package:flutter_application_1/Models/Expense.dart';
import 'package:flutter_application_1/Providers/ExpenseProvider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';



class AddExpensePage extends ConsumerStatefulWidget {
  const AddExpensePage({super.key});

  @override
  ConsumerState<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends ConsumerState<AddExpensePage> {
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final List<Category> categories = [
    Category(name: 'Food', icon: Icons.food_bank, color: Colors.orange),  
    Category(name: 'Transport', icon: Icons.car_rental, color: Colors.purpleAccent),
    Category(name: 'Billing', icon: Icons.receipt, color: Colors.green),
    Category(name: 'Shopping', icon: Icons.shopping_bag, color: const Color.fromARGB(255, 114, 114, 0)),
  ];
  TextEditingController dateController = TextEditingController();
  late Category _selectedCategory = categories[0];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Add Expense'),
      ),
      body:
      Padding(padding: EdgeInsetsGeometry.all(10), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detail', style: TextStyle(fontSize: 16),),
          TextFormField(controller: _detailController,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),)),
          SizedBox(height: 15,),

          Text('Amount', style: TextStyle(fontSize: 16),),
          TextField(controller: _amountController,decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),), prefixText: '\$', prefixStyle:TextStyle(fontWeight: FontWeight.bold, fontSize: 18),), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number, inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],),
          SizedBox(height: 15,),

          Text('Category', style: TextStyle(fontSize: 16),),
          Wrap(
            children: [
            for(var category in categories)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                       _selectedCategory = category;
                    });
                   
                  },

                  child: Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: category == _selectedCategory
                      ? category.color
                      :Colors.white,

                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 0.5, color: Colors.grey) 
                    ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(category.icon, 
                      color: category == _selectedCategory
                        ? Colors.white
                        :Colors.black,),
                      SizedBox(width: 8,),
                      Text(category.name, style: TextStyle(color:category == _selectedCategory
                        ? Colors.white
                        :Colors.black,),)
                    ],
                  ),
                ),
                )

                
                
              ),
            ],
          ),
          
          
          Divider(),
          Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: SizedBox(
              width: double.infinity,
              
              child: 
              GestureDetector(
                onTap:() {
                _selectDate();
              },

                child: Row(
                  children: [
                  
                  Text('Date', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                  Expanded(child: SizedBox(), ),
                  
                  
                  Text(dateController.text, style: TextStyle(fontSize: 16),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.calendar_today_outlined),
                  ),
                  
                  ],
              ),
            )
            ),
          ),
          Divider(),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Expense newexpense = Expense(name: _detailController.text, amount: _amountController.text, date: dateController.text.substring(0,6), categoryName: _selectedCategory.name, iconCodePoint: _selectedCategory.icon.codePoint, iconFontFamily: _selectedCategory.icon.fontFamily ?? '', colorVal: _selectedCategory.color.toARGB32());
                  ref.read(expenselistProvider.notifier).add(newexpense);
                  context.go('/');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                  child: Text('Save Expense', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              )
            ],
          ),
          SizedBox(height: 20,)
          
          

        ],

      ),) 
      
      
    );

    
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );

    if (picked != null) {
      setState(() {
        dateController.text = DateFormat.yMMMd().format(picked);
      });
    }


  }
}