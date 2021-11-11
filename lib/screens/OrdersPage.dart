
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app103/screens/OrderDetail.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Viewer {
  SELLER,
  USER,
}

class OrdersPage extends StatefulWidget {

  const OrdersPage({ Key? key, this.viewer = Viewer.USER }) : super(key: key);
  final Viewer viewer;

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.viewer == Viewer.SELLER ? AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black38,),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "FEMALEPRENEURE BAZAAR",
          style: TextStyle(color: Colors.black38),
        ),
      ) : null,
      body: Container(
        child: FutureBuilder<QuerySnapshot>(
          future: widget.viewer == Viewer.USER ?
          FirebaseFirestore.instance.collection("orders").where("user",isEqualTo: context.read(authenticatedUserProvider).documentId).orderBy("ordered_at", descending: true).get()
          : FirebaseFirestore.instance.collection("orders").where("seller",isEqualTo: context.read(authenticatedUserProvider).documentId).orderBy("ordered_at", descending: true).get(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator(),);
            if(snapshot.hasData){
              return ListView.builder(
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index){
                var order = snapshot.data!.docs[index];
                var data = order.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:8.0),
                  child: ListTile(
                    title: Text("Order ID #${data["orderCode"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    subtitle: Text("${data["items"].length} items    ${data["total"]} TK",),
                    trailing: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0xffdbdbdb),),
                      ),
                      child: Text(data["status"]),
                    ),
                    shape: Border.all(color: Color(0xffdbdbdb),),
                    onTap: (){
                      Navigator.push(
                        context, MaterialPageRoute(
                          builder: (ctx) => OrderDetails(order: order,viewer: widget.viewer,),
                        ),
                      );
                    },
                  ),
                );
              },
            );
            }
            return Center(
              child: Text("No Orders yet."),
            );
          },
        ),
      ),
    );
  }
}