import 'package:VipCustom/providers/order.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatefulWidget {
  final Order order;

  OrderItems(this.order);

  @override
  _OrderItemsState createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('R\$${widget.order.price}'),
            subtitle: Text(
              'Teste',
            ),
            trailing: IconButton(
              icon: Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          // if (_expanded)
          //   Container(
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 15,
          //       vertical: 4,
          //     ),
          //     height: (widget.order.products.length * 25.0) + 10,
          //     child: ListView(
          //       children: widget.order.products.map((product) {
          //         return Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: <Widget>[
          //             Text(
          //               product.title,
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             ),
          //             Text(
          //               '${product.quantity}x R\$${product.price.toStringAsFixed(2)}',
          //               style: TextStyle(
          //                 fontSize: 18,
          //                 color: Colors.grey,
          //               ),
          //             ),
          //           ],
          //         );
          //       }).toList(),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
