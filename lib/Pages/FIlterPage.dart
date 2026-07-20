import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/Category.dart';
import 'package:flutter_application_1/Models/Expense.dart';
import 'package:flutter_application_1/Providers/Filter_criteria.dart';
import 'package:flutter_application_1/Providers/ExpenseProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class Filterpage extends ConsumerStatefulWidget{
  const Filterpage({super.key});

  @override
  ConsumerState<Filterpage> createState() => _FilterpageState();
}

class _FilterpageState extends ConsumerState<Filterpage>{

  RangeValues _currentRangeValues = const RangeValues(0, 1000);
  DateTimeRange? _selectedDateRange;
  final List<Category> categories = [
    Category(name: 'Food', icon: Icons.food_bank, color: Colors.orange),  
    Category(name: 'Transport', icon: Icons.car_rental, color: Colors.purpleAccent),
    Category(name: 'Billing', icon: Icons.receipt, color: Colors.green),
    Category(name: 'Shopping', icon: Icons.shopping_bag, color: const Color.fromARGB(255, 114, 114, 0)),
  ];
  TextEditingController dateController = TextEditingController();
  Category? _selectedCategory;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Expenses'),
      ),
      body:
      Padding(padding: EdgeInsetsGeometry.all(10), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text('Amount', style: TextStyle(fontSize: 16),),
          RangeSlider(values: _currentRangeValues, 
          max: 1000,
          divisions: 100,
          activeColor: Colors.blue,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          }),
          
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
                  ExpenseFilter filter = ExpenseFilter(
                    category: _selectedCategory,
                    startDate: _selectedDateRange?.start,
                    endDate: _selectedDateRange?.end,
                    minAmount: _currentRangeValues.start.toInt(),
                    maxAmount: _currentRangeValues.end.toInt(),
                  );
                  ref.read(expenselistProvider.notifier).loadFilteredExpenses(filter);

                  context.go('/');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                  child: Text('Save Filter', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
                ),
              ),
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  
                  ref.read(expenselistProvider.notifier).clearFilter();

                  context.go('/');
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                  child: Text('Clear Filter', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20),),
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
  
    
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: _selectedDateRange,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDateRange) {
      setState(() {
         _selectedDateRange = picked;
    dateController.text = "${DateFormat('dd/MM/yyyy').format(picked.start)} - ${DateFormat('dd/MM/yyyy').format(picked.end)}";
      });
    }
   
    


  }
}