import 'dart:convert';

import 'package:VipCustom/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:VipCustom/providers/order.dart';
import 'package:flutter/foundation.dart';

class Orders with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_API_URL}/orders';
  List<Order> _items = [];
  String _token;

  Orders([this._token, this._items = const []]);

  List<Order> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> addOrder(Order newOrder) async {
    final response = await http.post(
      "$_baseUrl.json?auth=$_token",
      body: json.encode({
        'imageUrl': newOrder.imageUrl,
        'size': newOrder.size,
        'itemSelected': newOrder.itemSelected,
        'typeSelected': newOrder.typeSelected,
        'description': newOrder.description,
      }),
    );

    _items.add(Order(
      id: json.decode(response.body)['name'],
      imageUrl: newOrder.imageUrl,
      size: newOrder.size,
      itemSelected: newOrder.itemSelected,
      typeSelected: newOrder.typeSelected,
      description: newOrder.description,
    ));
    notifyListeners();
  }
}
