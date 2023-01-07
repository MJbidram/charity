class PayLinkModel {
  final String url;
  final int faktoorId;

  const PayLinkModel({
    required this.url,
    required this.faktoorId,
  });

  factory PayLinkModel.fromJson(Map<String, dynamic> json) {
    return PayLinkModel(
      url: json['url'],
      faktoorId: json['faktoorId'],
    );
  }
}
