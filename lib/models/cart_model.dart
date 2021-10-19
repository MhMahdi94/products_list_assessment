import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:product_list_assessment/models/Product.dart';

class CartModel extends ChangeNotifier {
  List<Product> products = [];
  double totalPrice = 0;

  void addProduct(Product product) {
    products.add(product);
    totalPrice += product.price!;
    notifyListeners();
  }

  void removeProduct(Product product) {
    totalPrice -= product.price!;
    products.remove(product);
    notifyListeners();
  }

  int get count {
    return products.length;
  }

  double get totPrice {
    return totalPrice;
  }

  List<Product> get basketProducts {
    return products;
  }
}
