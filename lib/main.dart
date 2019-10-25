import 'package:block_demo/bloc/cart_bloc.dart';
import 'package:block_demo/ui/cartScreen.dart';
import 'package:block_demo/ui/homeScreen.dart';
import 'package:block_demo/ui/productDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      builder: (context) => CartBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {'/cartScreen': (context) => CartScreen(),},
        onGenerateRoute: (settings) {
          if (settings.name == '/productDetail') {
            return MaterialPageRoute(
                  settings: settings,
                  builder: (context) => ProductDetail(settings.arguments));
          }
          return null;
        },
      ),
    );
  }
}