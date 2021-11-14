

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class TrackDelivery extends StatefulWidget {
  const TrackDelivery({ Key? key }) : super(key: key);

  @override
  _TrackDeliveryState createState() => _TrackDeliveryState();
}

class _TrackDeliveryState extends State<TrackDelivery> {

  TextEditingController orderCodeController = TextEditingController();
  var status;
  var message;
  bool showResult = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Track Delivery",
          style: TextStyle(color: Colors.black38),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: orderCodeController,
              decoration: InputDecoration(
                label: Text("Order ID"),
                hintText: "Enter Order id to check its status",
                suffix: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => _search(),
                )
              ),
              onFieldSubmitted: (value) => _search(),
            ),
            SizedBox(
              height: 20,
            ),
            if(showResult)
            Expanded(
              flex: 1,
              child: Center(
                
                child: _loading ? CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      status,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text(
                      message,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _search() async {
    setState(() {
      _loading = true;
    });
    var orders = await FirebaseFirestore.instance.collection("orders").where("orderCode", isEqualTo: orderCodeController.text.toUpperCase()).limit(1).get();
    if(orders.size > 0){
      var order = orders.docs.first;
      if(order.exists){
        var data = order.data() as dynamic;
        setState(() {
          _loading = false;
          showResult = true;
          status = data["status"];
          message = _getMessage(data["status"]);
        });
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Order Found.")));
    }
    Logger().wtf("${orders.size}");
  }

  String _getMessage(String status){
    // "Pending", "Accepted", "Processing", "Shipped", "Delivered"
    switch (status) {
      case "Accepted":
        return "Your order #${orderCodeController.text.toUpperCase()} is accepted by seller.";
      case "Processing":
        return "Your order #${orderCodeController.text.toUpperCase()} is currently being processed by seller.";
      case "Shipped":
        return "Your order #${orderCodeController.text.toUpperCase()} is shipped & will arrive soon at your doorstep.";
      case "Delivered":
        return "Your order #${orderCodeController.text.toUpperCase()} is delivered to you";
      default:
        return "Your order #${orderCodeController.text.toUpperCase()} is received and under review.";
    }
  }
}