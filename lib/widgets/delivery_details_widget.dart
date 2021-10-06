import 'package:flutter/material.dart';
import 'package:flutter_app103/models/order/Seller_transactions.dart';
import 'package:flutter_app103/models/order/delivey_details.dart';

class DeliveryDetailsWidget extends StatelessWidget {
  final DeliveryDetailsModel deliveryDetailsModel;
  const DeliveryDetailsWidget(this.deliveryDetailsModel, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), //color of shadow
            spreadRadius: 5, //spread radius
            blurRadius: 7, // blur radius
            offset: Offset(0, 2), // changes position of shadow
            //first paramerter of offset is left-right
            //second parameter is top to down
          ),
          //you can set more BoxShadow() here
        ],
      ),
      child: Row(children: [
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(deliveryDetailsModel.image),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10)),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${deliveryDetailsModel.name}"),
            Text("Code:${deliveryDetailsModel.shopName}"),
            Text("${deliveryDetailsModel.price} TK"),
            Text("QTY: ${deliveryDetailsModel.quantity}"),
          ],
        )
      ]),
    );
  }
}
