import 'dart:developer';

import 'package:block_demo/bloc/cart_bloc.dart';
import 'package:block_demo/bloc/cart_event.dart';
import 'package:block_demo/bloc/cart_state.dart';
import 'package:block_demo/model/cart_item/cartItem.dart';
import 'package:block_demo/numberFormat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CartBloc>(context);
  }

  _clearAllItem() {
    _bloc.add(ClearAllItemInTheCartEvent());
  }

  _removeCartItem(CartItem item, int index) {
    // _bloc.add(RemoveCartItemEvent(item, index));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thông báo"),
          content:
              new Text("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              textColor: Colors.red,
              child: new Text("Xóa"),
              onPressed: () {
                _bloc.add(RemoveCartItemEvent(item, index));
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Hủy"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _increaseCartItemQuantity(CartItem item, int index) {
    // debugger();
    _bloc.add(IncreaseCartItemQuantityEvent(item, index));
  }

  _decreaseCartItemQuantity(CartItem item, int index) {
    // debugger();
    if (item.quantity == 1) return;
    _bloc.add(DecreaseCartItemQuantityEvent(item, index));
  }

  _buildCartItem(CartItem item, int index) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.5, color: Colors.grey),
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: FlutterLogo(
              size: 100,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item.product.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () => _removeCartItem(item, index),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    NumberUtil.money(item.product.price),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Text(
                          'Số lượng: ${state.cartItems[index].quantity}',
                          style: TextStyle(fontSize: 18),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              size: 27,
                            ),
                            onPressed: () =>
                                _decreaseCartItemQuantity(item, index),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: 27,
                            ),
                            onPressed: () =>
                                _increaseCartItemQuantity(item, index),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.keyboard_backspace,
              size: 30,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: _clearAllItem,
            ),
          ],
          title: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Text(
                'Giỏ hàng (${_bloc.state.cartItems.length})',
                style: TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartBlankState || state.cartItems.isEmpty) {
              return Center(
                child: Text(
                  'Giỏ hàng trống !',
                  style: TextStyle(fontSize: 30, color: Colors.red),
                ),
              );
            } else if (state is CartHasItemState) {
              return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) =>
                    _buildCartItem(state.cartItems[index], index),
              );
            }
          },
        ),
      ),
    );
  }
}
