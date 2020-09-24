import 'package:VipCustom/views/confirmation_screen.dart';
import 'package:VipCustom/views/main_app.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Personalizar', 'screen': MainApp()},
      {'title': 'Meus Pedidos', 'screen': ConfirmationScreen()},
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedScreenIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Colors.lightBlue[200],
        unselectedItemColor: Colors.purple[200],
        selectedItemColor: Colors.purple,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_paint),
            title: Text('Personalizar'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title: Text('Pedidos'),
          ),
        ],
      ),
    );
  }
}
