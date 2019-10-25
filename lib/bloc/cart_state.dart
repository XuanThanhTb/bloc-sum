import 'package:block_demo/model/cart_item/cartItem.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart_state.g.dart';

@JsonSerializable()
class CartState {
  final List<CartItem> cartItems;
  const CartState(this.cartItems);

  factory CartState.fromJson(dynamic json) => _$CartStateFromJson(json);

  toJson() => _$CartStateToJson(this);
}

class InitialCartState extends CartState {
  InitialCartState(List<CartItem> cartItems) : super(cartItems);
}

class CartBlankState extends CartState {
  CartBlankState(List<CartItem> cartItems) : super(cartItems);
}

class CartHasItemState extends CartState {
  CartHasItemState(List<CartItem> cartItems) : super(cartItems);
}