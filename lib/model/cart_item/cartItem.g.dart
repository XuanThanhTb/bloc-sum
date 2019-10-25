// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return CartItem(
    json['product'],
    json['quantity'] as int,
  );
}

Map<String, dynamic> _$CartItemToJson(CartItem instance) => <String, dynamic>{
      'product': instance.product,
      'quantity': instance.quantity,
    };
