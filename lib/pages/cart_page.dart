import 'package:flutter/material.dart';
import 'package:product_list_assessment/models/cart_model.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          title: Text('Cart Page  '),
        ),
        body: cartModel.basketProducts.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.no_luggage,
                      size: 72,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No Items in your Cart',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartModel.count,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(cartModel.basketProducts[index].title
                                .toString()),
                            subtitle: Text(cartModel.basketProducts[index].price
                                .toString()),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                Fluttertoast.showToast(
                                  msg: "Item Deleted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red[300],
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                                cartModel.removeProduct(
                                    cartModel.basketProducts[index]);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '{Total Price:${cartModel.totPrice} \$}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Container(
                    width: 150,
                    // height: 60,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Successful Process",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Proceed',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.shopping_cart, color: Colors.white),
                          ],
                        )),
                  )
                ],
              ),
      );
    });
  }
}
