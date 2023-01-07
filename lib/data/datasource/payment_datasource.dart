import 'package:charity/di/di.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class IPaymentOperation {
  Future<PayLinkModel> getPaymentData(String type, String amount, String token);
  Future<void> launchUrlForPayment(String url);
}

class PaymentOperation implements IPaymentOperation {
  final Dio _dio = locator.get();

  @override
  Future<PayLinkModel> getPaymentData(
      String type, String amount, String token) async {
    _dio.options.headers["Authorization"] = "Bearer $token";
    var response = await _dio.post("pay", data: {
      "type": type,
      "amount": amount,
    });
    return PayLinkModel.fromJson(response.data);
  }

  @override
  Future<void> launchUrlForPayment(String url) async {
    try {
      await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalNonBrowserApplication);
    } catch (e) {}
  }
}
