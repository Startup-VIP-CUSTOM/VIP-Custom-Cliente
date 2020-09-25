import 'package:flutter/foundation.dart';

class Order with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String size;
  final String itemSelected;
  final String typeSelected;
  final String description;
  final String store;
  final String price;
  final bool confirmation;

  Order({
    this.id,
    @required this.imageUrl,
    @required this.size,
    @required this.itemSelected,
    @required this.typeSelected,
    @required this.description,
    @required this.store,
    @required this.price,
    this.confirmation = false,
  });
}
