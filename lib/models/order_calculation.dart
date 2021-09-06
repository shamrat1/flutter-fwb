import 'package:flutter/material.dart';

class OrderCalculation {
  final double? price;
  final double? deliveryCharge;
  final int? promoCode;
  final double? total;
  final int? orderNumber;
  final int? orderId;
  final String? orderDate;

  OrderCalculation(
      {@required this.price,
      @required this.deliveryCharge,
      @required this.promoCode,
      @required this.total,
      @required this.orderNumber,
      @required this.orderId,
      @required this.orderDate});
}
