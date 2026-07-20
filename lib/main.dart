import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/AddExpensepage.dart';
import 'package:flutter_application_1/Pages/FIlterPage.dart';

import 'package:flutter_application_1/Pages/HomePage.dart';
import 'package:flutter_application_1/Pages/MainShell.dart';
import 'package:flutter_application_1/Pages/Statspage.dart';
import 'package:flutter_application_1/isar_setup.dart';
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
    StatefulShellRoute.indexedStack(builder: (context, state, navigationShell) {
      return Mainshell(navshell: navigationShell);
    },
    branches: [
      StatefulShellBranch(
          routes: [
            GoRoute(
              name: "homepage",
              path: "/",
              builder: (context, state) {
                return const Homepage();
              },
            ),
          ],
        ),
      StatefulShellBranch(
          routes: [
            GoRoute(
              name: "addexpense",
              path: "/add",
              builder: (context, state) {
                return const AddExpensePage();
              },
            ),
          ],
        ),
      StatefulShellBranch(
          routes: [
            GoRoute(
              name: "statspage",
              path: "/stats",
              builder: (context, state) {
                return const Statspage();
              },
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            name: "filter",
            path: "/filter",
            builder: (context, state) {
              return const Filterpage();
            },
          )
        ])
      ],
      
    )
  ]
);