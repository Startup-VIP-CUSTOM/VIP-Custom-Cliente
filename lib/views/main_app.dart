import 'package:VipCustom/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(183, 255, 237, 0.9),
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('VIP Custom'),
      // ),
      drawer: Drawer(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.lightBlue[50],
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'Bem-Vindo à VIP Custom!',
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline6.color,
                      fontSize: 30,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  child: RaisedButton(
                    padding: EdgeInsets.all(75),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    //padding: EdgeInsets.all(100),
                    color: Theme.of(context).accentColor,
                    child: Column(
                      children: [
                        Icon(Icons.photo),
                        SizedBox(height: 25),
                        Text(
                          'Bora personalizar?',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.CUSTOMIZATION_SCREEN,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
