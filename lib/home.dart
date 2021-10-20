import 'package:flutter/material.dart';
import 'package:product_list_assessment/models/Product.dart';
import 'package:product_list_assessment/models/cart_model.dart';
import 'package:product_list_assessment/pages/cart_page.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loading = true;
  //initialize list of products
  List<Product> products = [];

  void getHttpResponse(List<Product> arguments) async {
    var url = Uri.https('fakestoreapi.com', '/products', {'q': '{http}'});

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var responseData = convert.jsonDecode(response.body);
      print(responseData);
      //List<Product> products = [];
      for (var product in responseData) {
        Product item = Product(
            title: product["title"],
            price: double.parse(product["price"].toString()));

        //Adding product to the list.
        arguments.add(item);
        setState(() {
          loading = false;
        });
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    getHttpResponse(products);
    // print(items);
    return Consumer<CartModel>(
      builder: (context, cartModel, child) {
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartPage()));
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),
                    Text(cartModel.count.toString())
                  ],
                ),
              )
            ],
          ),
          body: loading
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(products[index].title.toString()),
                      subtitle: Text(products[index].price.toString()),
                      trailing: Icon(Icons.add),
                      onTap: () {
                        cartModel.addProduct(products[index]);
                      },
                    );
                  },
                  itemCount: products.length,
                ),
        );
      },
    );
  }
}
