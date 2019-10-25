import 'package:block_demo/model/product/product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cartItem.g.dart';

@JsonSerializable()
class CartItem {
  Product product;
  int quantity;

  CartItem(this.product, this.quantity);

  factory CartItem.fromJson(dynamic json) => _$CartItemFromJson(json);

  toJson() => _$CartItemToJson(this);
}