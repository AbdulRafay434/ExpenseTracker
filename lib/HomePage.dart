import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/ExpenseProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  
  @override
  Widget build(BuildContext context) {
    
    final expenses = ref.watch(expenselistProvider);
    
    double totalval = 0.00;
    for (var expense in expenses) {
      totalval += double.tryParse(expense.amount) ?? 0.00;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Expenses", style: TextStyle(fontWeight: FontWeight.bold),),
              centerTitle: false, 
              elevation: 5,
              actions: [GestureDetector(
                onTap: () {
                  context.pushNamed("statspage");
                },
                child: 
                  Padding(padding: EdgeInsetsGeometry.only(right: 10), 
                      child: Icon(Icons.stacked_bar_chart_outlined) ,) ,
              )

                ],) ,

      body: 
        Column(
          children: [
            Padding(padding: EdgeInsetsGeometry.all(20), 
            child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue,),
              width: double.infinity,
              height: 140,
              child: Padding(padding: EdgeInsetsGeometry.all(20), 
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Text('Total Spent', style: TextStyle(color: Colors.white, fontSize: 24),),
                  
                  
                  Text('\$${totalval.toString()}', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                ],
              ),)
              ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    
                    
                      
                    

                    return Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(width: 0.5, color: Colors.grey)),
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: expense.category.color ),
                              child: Icon(expense.category.icon, size: 30, color: Colors.white,),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(expense.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
                                Row(
                                  children: [
                                    Text(expense.category.name, style: TextStyle(fontSize: 18),),
                                    Padding(padding: EdgeInsets.all(2), child:  Text(".", style: TextStyle(fontSize: 18),),),
                                    Text(expense.date, style: TextStyle(fontSize: 18),)
                                  ]
                                  
                                )
                              ],
                            
                            ),
                          ),
                          Expanded(child: SizedBox()),

                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('\$${expense.amount}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          )

                        ],
                      ),
                    );
                  },),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
         context.pushNamed("addexpense");
        },
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white,),
    ));
  }
}