import 'package:flutter/material.dart';
import 'package:flutter_products_app/viewmodels/products_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsViewmodel>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
      ),
      body: Consumer<ProductsViewmodel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          if (vm.error != null) {
            return Center(child: Text('No products found'));
          }

          return GridView.builder(
            itemCount: vm.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, index) {
              final product = vm.products[index];
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      product.title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),

                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.network(product.thumbnail),
                    ),
                    Text(
                      '₹ ${product.price.toString()}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
