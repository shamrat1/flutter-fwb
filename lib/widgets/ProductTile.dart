
import 'package:flutter/material.dart';
import 'package:flutter_app103/models/Cart.dart';
import 'package:flutter_app103/state/CartState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({
    Key? key,
    required this.singleProduct,
    required this.productID,
  }) : super(key: key);

  final Map<String, dynamic> singleProduct;
  final String productID;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(context.read(cartListPorvider).length > 0){
          if(singleProduct["owner"] != context.read(cartListPorvider).first.product["owner"]){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Products from different store already exists. Delete them first than try adding")));
            return;
          }

        }
        var item =  context.read(cartListPorvider).where((element) => element.id == productID);
        if(item.length > 0){

          context.read(cartListPorvider.notifier).increment(item.first);
        }else{
          var cart = Cart(
            productID,
            singleProduct,
            double.parse(singleProduct["price"] ?? 0),
            1
          );
          context.read(cartListPorvider.notifier).add(cart);
        }

        // Logger().w(singleProduct);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(),
            image: DecorationImage(
              image: NetworkImage(singleProduct["image"] ?? "https://via.placeholder.com/150"),
              fit: BoxFit.fill
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // height: 50,
              width: 100,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
              ),
              child: Column(
                
                children: [
                  Text(singleProduct["name"] ?? "Product Name",maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,),
                  Text((singleProduct["price"] ?? "" )+ " TK"),
            
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
