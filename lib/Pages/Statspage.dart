import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/ExpenseProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Statspage extends ConsumerWidget {
  const Statspage({super.key});

  
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final expenses = ref.watch(expenselistProvider);
    final totalamount = expenses.fold(0,(total, expense) => total + expense.amount);
    final totals = <String, double>{};
    for (final e in expenses) {
      totals[e.category.name] = (totals[e.category.name] ?? 0) + e.amount;

    }
    return Scaffold(
      appBar: AppBar(
        title: Text("\$${totalamount.toString()}",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: PieChart(
              
              PieChartData(
                centerSpaceColor: Colors.grey,
                centerSpaceRadius: 0,
                sectionsSpace: 0,
                sections: [
                  PieChartSectionData(value: totals["Billing"] ?? 0, color: Colors.green, title: "Billing", radius: 100),
                  PieChartSectionData(value: totals["Transport"] ?? 0, color: Colors.purpleAccent, title: "Transport", radius: 100 ),
                  PieChartSectionData(value: totals["Food"] ?? 0, color: Colors.orange, title: "Food", radius: 100),
                  PieChartSectionData(value: totals["Shopping"] ?? 0, color: Color.fromARGB(255, 114, 114, 0), title: "Shopping", radius: 100 ),
                ],
              )),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      
                      children: [
                        Icon(Icons.receipt, color: Colors.green),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Billing", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                        ),
                        Expanded(child: SizedBox()),
                        Text("\$${(totals["Billing"] ?? 0).toString()}", style: TextStyle(fontSize: 18),),
                        
                      ],
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: LinearProgressIndicator(value:((totals["Billing"]?? 0)/(totalamount)), color: Colors.green,minHeight: 15,),
                    )
                    ,
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      
                      children: [
                        Icon(Icons.car_rental, color: Colors.purpleAccent,),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Tansport", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                        ),
                        Expanded(child: SizedBox()),
                        Text("\$${(totals["Transport"] ?? 0).toString()}", style: TextStyle(fontSize: 18),),
                        
                      ],
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: LinearProgressIndicator(value:((totals["Transport"]?? 0)/(totalamount)), color: Colors.purpleAccent,minHeight: 15,),
                    )
                    ,
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      
                      children: [
                        Icon(Icons.food_bank, color: Colors.orange,),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Food", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                        ),
                        Expanded(child: SizedBox()),
                        Text("\$${(totals["Food"] ?? 0).toString()}", style: TextStyle(fontSize: 18),),
                        
                      ],
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: LinearProgressIndicator(value:((totals["Food"]?? 0)/(totalamount)), color: Colors.orange,minHeight: 15,),
                    )
                    ,
                  )
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 0.5),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      
                      children: [
                        Icon(Icons.shopping_bag, color: Color.fromARGB(255, 114, 114, 0),),

                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text("Shopping", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                        ),
                        Expanded(child: SizedBox()),
                        Text("\$${(totals["Shopping"] ?? 0).toString()}", style: TextStyle(fontSize: 18),),
                        
                      ],
                    ),
                  ),
                 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(10),
                      child: LinearProgressIndicator(value:((totals["Shopping"]?? 0)/(totalamount)), color: Color.fromARGB(255, 114, 114, 0),minHeight: 15,),
                    )
                    ,
                  )
                ],
              ),
            ),
          ),
          

        ],
        
      ),


    );
  }
}