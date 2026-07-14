import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddExpensepage.dart';

import 'package:flutter_application_1/HomePage.dart';
import 'package:flutter_application_1/isar_setup.dart';
import 'package:flutter_application_1/statspage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<void> main() async {
  await setupIsar();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
    );
    
  }

  
}
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      name: "/",
      path:"/" ,
      builder: (context, state) {
        return const Homepage();
      },
    ),
    GoRoute(
      name: "addexpense",
      path: "/addexpense",
      builder: (context, state) {
        return const AddExpensePage();
      },
    ),
    GoRoute(
      name: "statspage",
      path: "/statspage",
      builder: (context, state) {
        return const Statspage();
      },
    ),
  ]
);