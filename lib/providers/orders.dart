import 'dart:convert';

import 'package:VipCustom/exceptions/http_exeption.dart';
import 'package:VipCustom/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:VipCustom/providers/order.dart';

class Orders with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/clients';
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
        'id': newOrder.id,
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

    print(json.decode(response.body)['name']);

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

  //Daqui pra baixo nada é certeza

  Future<void> updateProduct(Order order) async {
    if (order == null || order.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == order.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/$_userId/orders/${order.id}.json?auth=$_token",
        body: json.encode({
          'imageUrl': order.imageUrl,
          'size': order.size,
          'itemSelected': order.itemSelected,
          'typeSelected': order.typeSelected,
          'description': order.description,
          'store': order.store,
          'price': order.price,
          'confirmation': order.confirmation,
        }),
      );
      _items[index] = order;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final order = _items[index];
      _items.remove(order);
      notifyListeners();

      final response = await http
          .delete("$_baseUrl/$_userId/orders/${order.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
        _items.insert(index, order);
        notifyListeners();
        throw HttpException('Ocorreu um erro na exclusão do produto.');
      }
    }
  }
}
