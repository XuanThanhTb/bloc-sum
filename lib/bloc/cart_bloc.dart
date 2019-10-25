import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:block_demo/model/cart_item/cartItem.dart';
import 'package:block_demo/model/product/product.dart';
import './bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  @override
  CartState get initialState => getInitialState();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is AddCartItemEvent) {
      yield* _addCartItem(event.item, event.item.quantity);
    } else if (event is RemoveCartItemEvent) {
      yield* _removeCartItem(event.item, event.index);
    } else if (event is UpdateCartItemEvent) {
      yield* _updateCartItem(event.item, event.index);
    } else if (event is IncreaseCartItemQuantityEvent) {
      yield* _offsetCartItemQuantity(event.item, event.index, 1);
    } else if (event is DecreaseCartItemQuantityEvent) {
      yield* _offsetCartItemQuantity(event.item, event.index, -1);
    } else if (event is ClearAllItemInTheCartEvent) {
      yield* _clearAllItemInTheCart();
    }
  }

  Stream<CartState> _addCartItem(CartItem item, int quantity) async* {
    var items = state.cartItems;
    var existedIndex = items.indexWhere((i) => i.product.id == item.product.id);
    if (existedIndex == -1) {
      yield CartHasItemState(List.from(items)..insert(0, item));
    }

    var newItems = List<CartItem>.from(items);
    newItems[existedIndex].quantity += quantity;
    yield CartHasItemState(newItems);
  }

  Stream<CartState> _removeCartItem(CartItem item, int index) async* {
    var items = state.cartItems;
    if (index != null) {
      yield CartHasItemState(List.from(items)..removeAt(index));
    } else {
      var newItems = List<CartItem>.from(items);
      var index = newItems.indexWhere((i) => i.product.id == item.product.id);
      if (index != -1) {
        newItems.removeAt(index);
      }
      yield CartHasItemState(newItems);
    }
  }

  Stream<CartState> _updateCartItem(CartItem item, int index) async* {
    var items = state.cartItems;
    var newItems = List.from(items);
    newItems[index] = item;
    yield CartHasItemState(newItems);
  }

  Stream<CartState> _offsetCartItemQuantity(
      CartItem item, int index, int offset) async* {
    var items = state.cartItems;
    var newItems = List<CartItem>.from(items);
    int itemIndex = -1;
    if (index != null) {
      itemIndex = index;
    } else {
      itemIndex = items.indexWhere((i) => i.product.id == item.product.id);
    }

    if (itemIndex != -1) {
      newItems[itemIndex].quantity += offset;
    }

    yield CartHasItemState(newItems);
  }

  Stream<CartState> _clearAllItemInTheCart() async* {
    var items = state.cartItems;
    yield CartBlankState(List.from(items)..clear());
  }

  getInitialState() {
    List<CartItem> list;
    var productA = Product(1, 'Product A', 230000);
    var productB = Product(2, 'Product B', 450000);
    var productC = Product(3, 'Product C', 790000);
    list = [
      CartItem(productA, 3),
      CartItem(productB, 1),
      CartItem(productC, 5),
    ];

    if (list.isEmpty)
      return CartBlankState(list);
    else
      return CartHasItemState(list);
  }
}
