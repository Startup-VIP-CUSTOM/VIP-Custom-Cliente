import 'package:VipCustom/providers/auth.dart';
import 'package:VipCustom/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.account_circle),
                  color: Colors.black,
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AppRoutes.COMPLEMENTATION_SCREEN),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  color: Colors.red,
                  onPressed: () {
                    showDialog<Null>(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Sair'),
                        content:
                            Text('Tem certeza que deseja sair da sua conta?'),
                        actions: <Widget>[
                          FlatButton(
                              child: Text('Sim'),
                              onPressed: () {
                                Provider.of<Auth>(context, listen: false)
                                    .logout();
                                Navigator.of(context)
                                    .pushReplacementNamed(AppRoutes.AUTH_HOME);
                              }),
                          FlatButton(
                            child: Text('Cancelar'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
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
                        Icon(Icons.format_paint),
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
