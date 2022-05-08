class SkuOrder {
  int count;
  String sku_key;

  // Constructor, with syntactic sugar for assignment to members.
  SkuOrder(this.count, this.sku_key) {}

  Map<String, dynamic> toJson() {
    return {'sku_key': sku_key, 'count': count};
  }
}
