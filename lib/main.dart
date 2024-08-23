import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/pages/home_page.dart';
// import 'package:hive/hive.dart';

void main() async {
  // Initialize Hive
  await Hive.initFlutter();

  // Open the box, but don't assign it to a variable
  await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ToDos",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white, // Set the color for the title
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors
              .purple, // Ensure the AppBar has the correct background color
        ),
      ),
      home: const HomePage(),
    );
  }
}
