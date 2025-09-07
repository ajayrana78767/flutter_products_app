import 'package:flutter/material.dart';
import 'package:flutter_products_app/view/products_screen.dart';
import 'package:flutter_products_app/viewmodels/products_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsViewmodel(),
      child: MaterialApp(
        title: 'Flutter Products App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
