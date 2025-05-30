import 'package:flutter/material.dart';
import 'package:flutter_application_laboratorio/pages/Home.dart';
import 'package:flutter_application_laboratorio/services/database_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().initializeDatabase();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      
      home: const MyHomePage(title: 'Lab 7'),
    );

  }
}
//WidgetsFlutterBinding.ensureInitialized();
//runApp(const MyApp());
