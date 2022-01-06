import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_oppwa/src/models.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'src/enums.dart';

export 'src/models.dart';
export 'src/enums.dart';

// TODO(OG): things to implement
// com.oppwa.mobile.connect.payment.bankaccount
// com.oppwa.mobile.connect.payment.card
// com.oppwa.mobile.connect.payment.googlepay
// com.oppwa.mobile.connect.payment.applepay
// com.oppwa.mobile.connect.payment.stcpay
// com.oppwa.mobile.connect.payment.token
// com.oppwa.mobile.connect.connect.utils
class FlutterOppwa {
  static const MethodChannel _channel = MethodChannel('flutter_oppwa');
  static const String testEndpoint = "http://52.59.56.185";
  static const String visa = "4200000000000000";
  static const String master = "5454545454545454";
  static const String amex = "377777777777770";
  static const String visa3dEnrolled = "4711100000000000";
  static const String master3dEnrolled = "5212345678901234";
  static const String amex3dEnrolled = "375987000000005";
  static Future<bool?> initialize(ProviderMode mode) async {
    try {
      final bool? didInitialize =
          await _channel.invokeMethod('initialize', <String, dynamic>{
        "mode": mode.index,
      });
      return didInitialize;
    } on PlatformException catch (e) {
      PaymentError? error;
      if (e.details is Map<String, dynamic>) {
        PaymentError.fromMap(e.details);
      }
      throw FlutterOppwaException(
          errorCode: e.code, errorMessage: e.message, paymentError: error);
    }
  }

  static Future<Transaction?> submitCardTransaction(
      CardTransaction transaction) async {
    try {
      final Map<String, dynamic>? result = await _channel.invokeMapMethod(
          'card_transaction', transaction.toMap());
      if (result != null) {
        return Transaction.fromMap(result);
      }
    } on PlatformException catch (e) {
      _handleError(e);
    }
  }

  static Future<CheckoutInfo?> requestCheckoutInfo(String checkoutId) async {
    try {
      final Map<String, dynamic>? result = await _channel
          .invokeMapMethod('checkout_info_request', {"checkoutId": checkoutId});
      if (result != null) {
        return CheckoutInfo.fromMap(result);
      }
    } on PlatformException catch (e) {
      _handleError(e);
    }
  }

  static Future<String?> getTestCheckoutId(
      double amount, String currency, PaymentType paymentType) async {
    var client = http.Client();
    try {
      var url = Uri.parse('$testEndpoint/token').replace(queryParameters: {
        "amount": amount.round().toString(),
        "currency": currency,
        "paymentType": paymentType.value,
        "notificationUrl": "$testEndpoint:80/notification",
      });
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        var checkoutId = decodedResponse['checkoutId'] as String?;
        return checkoutId;
      } else {
        throw FlutterOppwaException(
          errorCode: "request_failed",
          errorMessage:
              "response ended with status code '${response.statusCode}'",
        );
      }
    } on FlutterOppwaException catch (_) {
      rethrow;
    } on Exception catch (e) {
      throw FlutterOppwaException(
          errorCode: "request_failed", errorMessage: e.toString());
    } finally {
      client.close();
    }
  }

  static Future<String?> requestTestPaymentStatus(String resourcePath) async {
    var client = http.Client();
    try {
      var url = Uri.parse('$testEndpoint/status').replace(queryParameters: {
        "resourcePath": resourcePath,
      });
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decodedResponse =
            jsonDecode(utf8.decode(response.bodyBytes)) as Map;
        print(decodedResponse);
        var paymentResult = decodedResponse['paymentResult'] as String?;
        return paymentResult;
      } else {
        throw FlutterOppwaException(
          errorCode: "request_failed",
          errorMessage:
              "response ended with status code '${response.statusCode}'",
        );
      }
    } on FlutterOppwaException catch (_) {
      rethrow;
    } on Exception catch (e) {
      throw FlutterOppwaException(
          errorCode: "request_failed", errorMessage: e.toString());
    } finally {
      client.close();
    }
  }

  static void _handleError(PlatformException exception) {
    PaymentError? error;
    if (exception.details is Map<Object?, Object?>) {
      var details = exception.details as Map<Object?, Object?>;
      error = PaymentError.fromMap(details.cast<String, dynamic>());
    }
    throw FlutterOppwaException(
        errorCode: exception.code,
        errorMessage: exception.message,
        paymentError: error);
  }
}
