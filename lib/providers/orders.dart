import 'dart:convert';

import 'package:VipCustom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:VipCustom/providers/order.dart';

class Orders with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}';
  List<Order> _items = [];
  String _token;
  String _userId;

  Orders([this._token, this._userId, this._items = const []]);

  List<Order> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Order newOrder) async {
    final response = await http.post(
      "$_baseUrl/$_userId/orders.json?auth=$_token",
      body: json.encode({
        'imageUrl': newOrder.imageUrl,
        'size': newOrder.size,
        'itemSelected': newOrder.itemSelected,
        'typeSelected': newOrder.typeSelected,
        'description': newOrder.description,
        'store': newOrder.store,
        'price': newOrder.price,
        'confirmation': false,
      }),
    );

    _items.add(Order(
      id: json.decode(response.body)['name'],
      imageUrl: newOrder.imageUrl,
      size: newOrder.size,
      itemSelected: newOrder.itemSelected,
      typeSelected: newOrder.typeSelected,
      description: newOrder.description,
      store: newOrder.store,
      price: newOrder.price,
      confirmation: false,
    ));
    notifyListeners();
  }

  Future<void> loadProducts() async {
    final response =
        await http.get('$_baseUrl/$_userId/orders.json?auth=$_token');
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(Order(
          id: productId,
          imageUrl: productData['imageUrl'],
          size: productData['size'],
          itemSelected: productData['itemSelected'],
          typeSelected: productData['typeSelected'],
          description: productData['description'],
          price: productData['price'],
          store: productData['store'],
          confirmation: productData['confirmation'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }
}
