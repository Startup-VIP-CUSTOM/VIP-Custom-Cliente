import 'package:VipCustom/providers/auth.dart';
import 'package:VipCustom/providers/orders.dart';
import 'package:VipCustom/providers/prices.dart';
import 'package:VipCustom/utils/app_routes.dart';
import 'package:VipCustom/views/auth_home_screen.dart';
//import 'package:VipCustom/views/confirmation_screen.dart';
import 'package:VipCustom/views/customization_screen.dart';
import 'package:VipCustom/views/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Orders(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Prices(),
        ),
      ],
      child: MaterialApp(
        title: 'VIP Custom',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          accentColor: Colors.deepPurple[100],
          fontFamily: 'Raleway',
        ),
        routes: {
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.HOME: (ctx) => TabsScreen(),
          AppRoutes.CUSTOMIZATION_SCREEN: (ctx) => CustomizationScreen(),
          //AppRoutes.CONFIRMATION_SCREEN: (ctx) => ConfirmationScreen(),
        },
        //home: MainApp(),
      ),
    );
  }
}
