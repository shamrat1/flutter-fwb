
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
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0))
              ),
              child: Column(
                
                children: [
                  Text(singleProduct["name"] ?? "Product Name"),
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
