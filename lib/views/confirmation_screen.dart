import 'package:VipCustom/widgets/order_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders.dart';

class ConfirmationScreen extends StatefulWidget {
  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<Orders>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    //final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[100],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).loadProducts(),
          builder: (cxt, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return Center(child: Text('Ocorreu um erro inesperado!'));
            } else {
              return Consumer<Orders>(
                builder: (cxt, orders, child) {
                  return ListView.builder(
                    itemCount: orders.itemsCount,
                    itemBuilder: (ctx, i) => OrderItems(orders.items[i]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
