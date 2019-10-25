import 'package:block_demo/model/cart_item/cartItem.dart';

abstract class CartEvent {
  const CartEvent();
}

class AddCartItemEvent extends CartEvent {
  final CartItem item;
  AddCartItemEvent(this.item);
}

class RemoveCartItemEvent extends CartEvent {
  final CartItem item;
  final int index;

  RemoveCartItemEvent(this.item, this.index);
}

class UpdateCartItemEvent extends CartEvent {
  final CartItem item;
  final int index;

  UpdateCartItemEvent(this.item, this.index);
}

class IncreaseCartItemQuantityEvent extends CartEvent {
  final CartItem item;
  final int index;

  IncreaseCartItemQuantityEvent(this.item, this.index);
}

class DecreaseCartItemQuantityEvent extends CartEvent {
  final CartItem item;
  final int index;

  DecreaseCartItemQuantityEvent(this.item, this.index);
}

class ClearAllItemInTheCartEvent extends CartEvent {
  ClearAllItemInTheCartEvent();
}