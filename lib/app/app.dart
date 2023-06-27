
import 'package:flutter/material.dart';

import '../presentation/resources/route_manager.dart';
import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  //const MyApp({super.key});
  MyApp._internal();  //Private Named Constructor
  int appState = 0;
  static final MyApp instance = MyApp._internal();  //Single Instance -- Singleton
  factory MyApp() =>instance; //factory for class Instance
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.main,
      theme: getApplicationTheme(),
    );
  }
}
