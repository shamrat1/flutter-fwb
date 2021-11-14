

import 'package:flutter/material.dart';
import 'package:flutter_app103/state/FavoriteProductsState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wishlist extends ConsumerWidget {

  @override
  Widget build(BuildContext context, watch) {
    var items = watch(favoriteProductsProvider);

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
      body: items.length > 0 ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Image.network(items[index].data["image"]),
                title: Text(items[index].data["name"]),
                subtitle: Container(
                  width: MediaQuery.of(context).size.width * .60,
                  child: Text(items[index].data["description"] ?? "", overflow: TextOverflow.ellipsis,),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.redAccent.shade200,),
                  onPressed: (){
                    context.read(favoriteProductsProvider.notifier).delete(items[index].wishlistId);
                  },
                ),
              ),
            );
          },
        ),
      ) : Center(child: Text("Nothing in wishlist"),),
    );
  }
}
