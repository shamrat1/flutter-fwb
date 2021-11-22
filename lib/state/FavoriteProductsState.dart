

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app103/state/AuthenticatedUserState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';


final favoriteProductsProvider = StateNotifierProvider<FavoriteProductsState, List<FavoriteProduct>>((ref) => FavoriteProductsState([], ref) );

class FavoriteProductsState extends StateNotifier<List<FavoriteProduct>>{

  final ProviderReference ref;
  FavoriteProductsState(List<FavoriteProduct> state, this.ref) : super(state){
    fetch();
  }

  void fetch() async {
    var response = await FirebaseFirestore.instance
    .collection("wishlists")
    .where("user_id", isEqualTo: ref.read(authenticatedUserProvider).documentId).get();
    if(response.size > 0){
      List<FavoriteProduct> list = [];
      response.docs.forEach((element) {
        var data = element.data() as dynamic;
        list.add(FavoriteProduct(
          element.id,
          data["product_id"],
          data["product"]));
      });
      state = list;
    }else{
      state = [];
    }
  }

  void change(List<FavoriteProduct> products) => state = products;

  void addFavorite(String id, Map<String,dynamic> data, String userId) async {
    var list = [...state];
    var item = await FirebaseFirestore.instance.collection("wishlists").add({
      	"user_id" : userId,
        "product_id" : id,
        "product" : data
    });
    list.add(FavoriteProduct(item.id,id, data));
    state  = list;
  }

  void delete(String wishlistID) async {
    var list = [...state];
    await FirebaseFirestore.instance.collection("wishlists").doc(wishlistID).delete();
    var index = list.indexWhere((element) => element.wishlistId == wishlistID);
    list.removeAt(index);
    // Logger().d("${wishlistID} | $index | ${state.length} | ${list.length}");
    change(list);
    // fetch();
  }
}


class FavoriteProduct {
  final String wishlistId;
  final String documentID;
  final Map<String, dynamic> data;

  FavoriteProduct(this.wishlistId, this.documentID, this.data);
}