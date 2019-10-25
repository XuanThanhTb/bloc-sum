import 'package:block_demo/bloc/cart_bloc.dart';
import 'package:block_demo/model/product/product.dart';
import 'package:block_demo/numberFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CartBloc _bloc;

  List<Product> products = [
    Product(1, 'Product A', 230000),
    Product(2, 'Product B', 450000),
    Product(3, 'Product C', 790000),
    Product(4, 'Product D', 2300000),
    Product(5, 'Product E', 150000),
    Product(6, 'Product F', 90000),
  ];

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CartBloc>(context);
  }

  _onProductClick(Product item) {
    Navigator.pushNamed(context, '/productDetail', arguments: item);
  }

  _onOpenCart() {
    Navigator.of(context).pushNamed('/cartScreen');
  }

  _buildProductItem(Product item) {
    return GestureDetector(
      onTap: () => _onProductClick(item),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Hero(
              tag: item.id,
              child: FlutterLogo(
                size: 80,
              ),
            ),
            Text(
              item.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              NumberUtil.money(item.price),
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('BloC Cart'),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    Text('Giỏ hàng (${_bloc.state.cartItems.length})'),
                  ],
                ),
                onTap: _onOpenCart,
              ),
            ],
          ),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.9,
          children: List.generate(
              products.length, (index) => _buildProductItem(products[index])),
        ),
      ),
    );
  }
}
