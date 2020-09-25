import 'package:VipCustom/exceptions/http_exeption.dart';
import 'package:VipCustom/providers/order.dart';
import 'package:VipCustom/providers/orders.dart';
import 'package:VipCustom/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderItems extends StatelessWidget {
  final Order order;

  OrderItems(this.order);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(order.imageUrl),
      ),
      title: Text(order.itemSelected),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CUSTOMIZATION_SCREEN,
                  arguments: order,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Excluir Produto'),
                    content: Text('Tem certeza?'),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Não'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      FlatButton(
                        child: Text('Sim'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ).then((value) async {
                  if (value) {
                    try {
                      await Provider.of<Orders>(context, listen: false)
                          .deleteProduct(order.id);
                    } on HttpException catch (error) {
                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text(error.toString()),
                        ),
                      );
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

//   final Order order;

//   OrderItems(this.order);

//   @override
//   _OrderItemsState createState() => _OrderItemsState();
// }

// class _OrderItemsState extends State<OrderItems> {
//   @override
//   Widget build(BuildContext context) {
//     final scaffold = Scaffold.of(context);

//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Column(
//         children: <Widget>[
//             ListTile(
//             title: Text('R\$${widget.order.price}'),
//             subtitle: Text(
//               widget.order.itemSelected,
//             ),
//             trailing: Row(
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   color: Theme.of(context).primaryColor,
//                   onPressed: () {
//                     Navigator.of(context).pushNamed(
//                       AppRoutes.CUSTOMIZATION_SCREEN,
//                       //arguments: order,
//                     );
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   color: Theme.of(context).errorColor,
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (ctx) => AlertDialog(
//                         title: Text('Excluir Produto'),
//                         content: Text('Tem certeza?'),
//                         actions: <Widget>[
//                           FlatButton(
//                             child: Text('Não'),
//                             onPressed: () => Navigator.of(context).pop(false),
//                           ),
//                           FlatButton(
//                             child: Text('Sim'),
//                             onPressed: () => Navigator.of(context).pop(true),
//                           ),
//                         ],
//                       ),
//                     ).then(
//                       (value) async {
//                         if (value) {
//                           // await Provider.of<Orders>(context, listen: false)
//                           //     .deleteProduct(order.id);

//                         }
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
