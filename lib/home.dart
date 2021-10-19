import 'package:flutter/material.dart';
import 'package:product_list_assessment/components/product_card.dart';
import 'package:product_list_assessment/models/Product.dart';
import 'package:product_list_assessment/models/cart_model.dart';
import 'package:product_list_assessment/pages/cart_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [
    Product(name: 'Jacket', price: 10.0, imagePath: 'assets/images/jacket.png'),
    Product(name: 'shirt', price: 10.0, imagePath: 'assets/images/shirt.jpg'),
    Product(name: 'shoes', price: 10.0, imagePath: 'assets/images/shoes.jpg'),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cartModel, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Assessment Cart'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                  Text(cartModel.count.toString())
                ],
              ),
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(products[index].name.toString()),
              subtitle: Text(products[index].price.toString()),
              trailing: Icon(Icons.add),
              onTap: () {
                cartModel.addProduct(products[index]);
              },
            );
            // return Column(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.all(16),
            //       child: ProductCard(
            //           title: 'Jacket',
            //           imgPath: 'assets/images/jacket.png',
            //           price: 10),
            //     ),
            //     SizedBox(
            //       height: 20,
            //     )
            //   ],
            // );
          },
          itemCount: products.length,
        ),
      );
    });
  }
}
