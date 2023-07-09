class OrderModel {
  OrderModel({
    required this.data,
  });
  late final OrderPayment data;

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = OrderPayment.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class OrderPayment {
  OrderPayment({
    required this.orderId,
    required this.payData,
  });
  late final int orderId;
  late final PayData payData;

  OrderPayment.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    payData = PayData.fromJson(json['pay_data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['order_id'] = orderId;
    _data['pay_data'] = payData.toJson();
    return _data;
  }
}

class PayData {
  PayData({
    required this.url,
    required this.faktoorId,
  });
  late final String url;
  late final int faktoorId;

  PayData.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    faktoorId = json['faktoorId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['faktoorId'] = faktoorId;
    return _data;
  }
}
