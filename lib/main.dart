import 'package:banking_system/constants/colors.dart';
import 'package:banking_system/database/database_service.dart';
import 'package:banking_system/database/user_db.dart';
import 'package:banking_system/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor:  DarkBlueColor,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: DarkBlueColor ),
        useMaterial3: true,
      ),
      home: HomeScreen(currentUser:  UserDB().fetchUserById(1),),
    );
  }
}

