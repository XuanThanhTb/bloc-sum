import 'package:block_demo/bloc/cart_bloc.dart';
import 'package:block_demo/bloc/cart_event.dart';
import 'package:block_demo/bloc/cart_state.dart';
import 'package:block_demo/model/cart_item/cartItem.dart';
import 'package:block_demo/model/product/product.dart';
import 'package:block_demo/numberFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatefulWidget {
  final dynamic param;
  ProductDetail(this.param);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  Product item;
  int quantity = 1;
  CartBloc _bloc;

  @override
  void initState() {
    super.initState();
    item = widget.param;
    _bloc = BlocProvider.of<CartBloc>(context);
  }

  _onOpenCart() {
    Navigator.of(context).pushNamed('/cartScreen');
  }

  _offsetQuantity(int offset) {
    if (quantity == 1 && offset == -1) return;
    setState(() {
      quantity += offset;
    });
  }

  _addToCart() {
    CartItem cartItem = CartItem(item, quantity);
    _bloc.add(AddCartItemEvent(cartItem));
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
              Text(item.name),
              GestureDetector(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.shopping_cart),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Text('Giỏ hàng (${state.cartItems.length})');
                      },
                    )
                  ],
                ),
                onTap: _onOpenCart,
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Hero(
                  tag: item.id,
                  child: FlutterLogo(
                    size: 250,
                  ),
                ),
              ),
              Text(
                item.name,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  NumberUtil.money(item.price),
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Số lượng: $quantity',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.remove_circle_outline,
                            size: 30,
                          ),
                          onPressed: () => _offsetQuantity(-1),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 30,
                          ),
                          onPressed: () => _offsetQuantity(1),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add_shopping_cart,
                      size: 30,
                    ),
                    onPressed: _addToCart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
