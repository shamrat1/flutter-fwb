

import 'package:flutter_app103/models/Cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var cartListPorvider = StateNotifierProvider<CartState, List<Cart>>((ref) => CartState([]));
class CartState extends StateNotifier<List<Cart>>{

  CartState(List<Cart> state) : super(state);

  void add(Cart cart){
    var items = [...state];
    items.add(cart);
    state = items;
  }

  void increment(Cart item){
    var items = [...state];
    var index = items.indexOf(item);
    item.quantity += 1;
    items.removeAt(index);
    items.insert(index, item);
    state = items;
  }

  void decrement(Cart item){
    var items = [...state];
    var index = items.indexOf(item);
    if(item.quantity > 1){
      item.quantity -= 1;
      items.removeAt(index);
      items.insert(index, item);
      state = items;
    }else{
      remove(index);
    }
  }

  void remove(int index){
    var items = [...state];
    items.removeAt(index);
    state = items;
  }
  void removeAll(){
    
    state = [];
  }

  double getSubtotal(){
    double total = 0;
    state.forEach((element) {
      total += (element.quantity * element.price);
    });
    return total;
  }
}