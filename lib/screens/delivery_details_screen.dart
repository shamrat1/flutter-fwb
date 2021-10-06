import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/order/delivey_details.dart';
import 'package:flutter_app103/models/order/order_calculation.dart';
import 'package:flutter_app103/widgets/delivery_details_widget.dart';

class DeliveryDetails extends StatefulWidget {
  DeliveryDetails({Key? key}) : super(key: key);

  @override
  _DeliverydetailsState createState() => _DeliverydetailsState();
}

class _DeliverydetailsState extends State<DeliveryDetails> {
  List<DeliveryDetailsModel> deliveryDetailsList = [
    DeliveryDetailsModel(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0),
    DeliveryDetailsModel(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0),
    DeliveryDetailsModel(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0),
    DeliveryDetailsModel(
        "https://images.unsplash.com/photo-1555507036-ab1f4038808a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YmFrZXJ5fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80",
        "Unicorn cake",
        "Cake House",
        2600,
        0),
  ];
  @override
  Widget build(BuildContext context) {
    final OrderCalculation orderCalculation = OrderCalculation(
        price: calculatePrice(),
        deliveryCharge: 50,
        promoCode: 30,
        total: calculateTotal(
          calculatePrice(),
          50,
          30,
        ),
        orderDate: '04/08/2021',
        orderId: 3,
        orderNumber: 66524);
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.arrow_left,
          color: Colors.black,
        ),
        title: Text(
          " Delivery details",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black38,
          ),
        ),
        actions: [
          Icon(
            CupertinoIcons.cart,
            color: Colors.black,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Order Number:'),
                    Text('Oder ID:'),
                    Text('Order Date:'),
                  ],
                ),
                SizedBox(
                  width: 150,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(orderCalculation.orderNumber.toString()),
                    Text(orderCalculation.orderId.toString()),
                    Text(orderCalculation.orderDate.toString()),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: deliveryDetailsList.length,
                itemBuilder: (context, index) {
                  return DeliveryDetailsWidget(deliveryDetailsList[index]);
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.indigo[200],
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Price Detail:'),
                      Text('Delivery Charge:'),
                      Text('Discount(%):'),
                      Text('Promo Code Discount:'),
                      Text('Final Total:'),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                  ),
                  orderCalculationColumn(OrderCalculation(
                      price: calculatePrice(),
                      deliveryCharge: 50,
                      promoCode: 30,
                      total: calculateTotal(
                        calculatePrice(),
                        50,
                        30,
                      ),
                      orderDate: '04/08/2021',
                      orderId: 3,
                      orderNumber: 66524))
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[50],
                      padding: EdgeInsets.all(5),
                      minimumSize: Size(5, 5)),
                  onPressed: () {},
                  child: Text("Cancel Order",
                      style: TextStyle(color: Colors.black)),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo[50],
                      padding: EdgeInsets.all(5),
                      minimumSize: Size(5, 5)),
                  onPressed: () {},
                  child: Text(
                    " Reorder",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  double calculateTotal(double price, double deliveryCharge, int promo) {
    double total = price - (price * promo / 100) + deliveryCharge;
    return total;
  }

  double calculatePrice() {
    double price = 0;
    deliveryDetailsList.forEach((element) {
      price = price + element.price;
    });
    return price;
  }

  Column orderCalculationColumn(OrderCalculation orderCalculation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(orderCalculation.price.toString()),
        Text(orderCalculation.deliveryCharge.toString()),
        Text(orderCalculation.promoCode.toString()),
        Text(orderCalculation.total.toString()),
      ],
    );
  }
}
