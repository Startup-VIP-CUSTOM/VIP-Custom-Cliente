import 'package:VipCustom/providers/auth.dart';
import 'package:VipCustom/views/auth_screen.dart';
import 'package:VipCustom/views/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (cxt, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text('Ocorreu um erro inesperado!'));
        } else {
          return auth.isAuth ? TabsScreen() : AuthScreen();
        }
      },
    );
  }
}
