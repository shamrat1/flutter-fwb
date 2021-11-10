

class Cart{
  final String id;
  final Map<String,dynamic> product;
  int quantity;
  final double price;
  
  Cart(this.id, this.product, this.price, this.quantity);
}