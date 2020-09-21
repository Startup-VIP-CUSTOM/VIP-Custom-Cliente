import 'package:flutter/foundation.dart';

class Order with ChangeNotifier {
  final String id;
  final String imageUrl;
  final String size;
  final String itemSelected;
  final String typeSelected;
  final String description;

  Order({
    this.id,
    @required this.imageUrl,
    @required this.size,
    @required this.itemSelected,
    @required this.typeSelected,
    @required this.description,
  });
}
