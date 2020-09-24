import 'package:flutter/material.dart';

class Prices with ChangeNotifier {
  static const String store1_name = 'Rainer';
  static const double store1_product1 = 30.0; // Camiseta Loja 1
  static const double store1_product2 = 7.0; // Chinelo Loja 1
  static const double store1_product3 = 1.5; // Máscara Loja 1
  static const String store2_name = 'João';
  static const double store2_product1 = 35.0; // Camiseta Loja 2
  static const double store2_product2 = 5.5; // Chinelo Loja 2
  static const double store2_product3 = 3.0; // Máscara Loja 2

  double store1Tax(String product) {
    if (product == 'camiseta') {
      return store1_product1 + (store1_product1 * 0.1);
    } else if (product == 'chinelo') {
      return store1_product2 + (store1_product2 * 0.1);
    } else if (product == 'mascara') {
      return store1_product3 + (store1_product3 * 0.1);
    } else {
      return null;
    }
  }

  double store2Tax(String product) {
    if (product == 'camiseta') {
      return store2_product1 + (store2_product1 * 0.1);
    } else if (product == 'chinelo') {
      return store2_product2 + (store2_product2 * 0.1);
    } else if (product == 'mascara') {
      return store2_product3 + (store2_product3 * 0.1);
    } else {
      return null;
    }
  }
}
