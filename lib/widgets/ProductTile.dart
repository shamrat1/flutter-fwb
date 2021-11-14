
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app103/models/Cart.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_app103/state/CartState.dart';
import 'package:flutter_app103/state/FavoriteProductsState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ProductTile extends StatelessWidget {
  ProductTile({
    Key? key,
    required this.singleProduct,
    required this.productID,
  }) : super(key: key);

  final Map<String, dynamic> singleProduct;
  final String productID;

  bool isWishlisted = false;
  FavoriteProduct? wishlistObj;
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // height: 50,
                        width: constraints.maxWidth,
                        // alignment: Alignment.bottomCenter,
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
                    Positioned(
                      right: 5,
                      top: 3,
                      child: Consumer(
                        builder: (context, watch, child) {
                          var favorites = watch(favoriteProductsProvider);
                          favorites.forEach((element){
                            if(element.documentID == productID){
                              isWishlisted = true;
                              wishlistObj = element;
                            }
                          });
                          return IconButton(
                            icon: Icon(isWishlisted ? Icons.favorite : Icons.favorite_outline,color: Colors.redAccent.shade200,),
                            onPressed: (){
                              try{
                                if(isWishlisted){
                                  context.read(favoriteProductsProvider.notifier)
                                  .delete(wishlistObj!.wishlistId);
                                }else{
                                  context.read(favoriteProductsProvider.notifier)
                                  .addFavorite(
                                    productID,
                                    singleProduct,
                                    context.read(authenticatedUserProvider).documentId!
                                  );
                                }
                              } finally {
                                // ScaffoldMessenger.of(context).showSnackBar(snackBar)
                              }
                            },
                          );
                        }
                      ),
                    ),
                  ],
                );
              }
            )
          ),
        );

  }
}
