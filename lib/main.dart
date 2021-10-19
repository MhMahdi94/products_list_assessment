import 'package:flutter/material.dart';
import 'package:product_list_assessment/home.dart';
import 'package:product_list_assessment/models/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  //runApp(const MyApp());
  runApp(ChangeNotifierProvider(
    create: (context) => CartModel(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
