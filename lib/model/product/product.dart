import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  int id;
  String name;
  int price;

  Product(this.id, this.name, this.price);

  factory Product.fromJson(dynamic json) => _$ProductFromJson(json);

  toJson() => _$ProductToJson(this);
}