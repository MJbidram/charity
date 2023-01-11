import 'package:charity/di/di.dart';
import 'package:charity/models/pay_link_model.dart';
import 'package:dartz/dartz.dart';

import '../datasource/payment_datasource.dart';

abstract class IpaymentRepository {
  Future<Either<String, PayLinkModel>> getPaymentData(
    String type,
    String amount,
    String token,
  );

  Future<Either<String, String>> launchUrlForPayment(String url);
}

class PaymentRepository implements IpaymentRepository {
  final IPaymentOperation _paymentOperation = locator.get();
  @override
  Future<Either<String, PayLinkModel>> getPaymentData(
      String type, String amount, String token) async {
    print('token ::  ' + token);
    try {
      final response =
          await _paymentOperation.getPaymentData(type, amount, token);
      print('response.faktoorId   :  ' + '${response.faktoorId}');
      return right(response);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> launchUrlForPayment(String url) async {
    try {
      await _paymentOperation.launchUrlForPayment(url);
      return right('launched browser');
    } catch (e) {
      return left('unable to lunch browser');
    }
  }
}
