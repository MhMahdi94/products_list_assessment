import 'package:flutter/material.dart';
import 'package:product_list_assessment/models/cart_model.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(builder: (context, cartModel, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Cart Page  {Total Price:${cartModel.totPrice} \$}'),
        ),
        body: cartModel.basketProducts.length == 0
            ? Text('No Items in your Cart')
            : ListView.builder(
                itemCount: cartModel.count,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title:
                          Text(cartModel.basketProducts[index].name.toString()),
                      subtitle: Text(
                          cartModel.basketProducts[index].price.toString()),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cartModel
                              .removeProduct(cartModel.basketProducts[index]);
                        },
                      ),
                    ),
                  );
                }),
      );
    });
  }
}
