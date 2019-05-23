import 'package:flutter/material.dart';
import 'package:logistics/pages/login.dart';
import 'package:logistics/pages/menu.dart';
// import 'package:logistics/pages/shipments.dart';
import 'package:logistics/pages/splash.dart';
import 'package:logistics/scoped_models/shipments_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ShipmentsModel model = ShipmentsModel();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ShipmentsModel>(
        model: model,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          routes: {
            '/': (BuildContext context) => SplashPage(),
            '/login': (BuildContext context) => LoginPage(),
            '/menu': (BuildContext context) => MenuPage(),
          },
        ));
  }
}
