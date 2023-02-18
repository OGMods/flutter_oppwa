import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_oppwa/src/parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_oppwa/flutter_oppwa.dart';

part 'flutter_oppwa_utils.dart';
part 'flutter_oppwa_test.dart';

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
  FlutterOppwa._();
  static Future<T?> _invoke<T>(String method,
      [Map<String, dynamic>? data]) async {
    try {
      return await _channel.invokeMethod<T>(method, data);
    } on PlatformException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<T?> _invokeMap<T>(
    String method,
    T Function(Map<String, dynamic> data) parser,
    Map<String, dynamic>? data,
  ) async {
    try {
      var result =
          await _channel.invokeMapMethod<String, dynamic>(method, data);
      print(result);
      if (result != null) {
        return parser(result);
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      throw _handleError(e);
    }
  }

  static Future<bool> initialize(ProviderMode mode) async {
    return await _invoke("initialize", {"mode": mode.name}) == true;
  }

  static Future<Transaction?> _submitTransaction(
      String method, BaseTransaction transaction) async {
    return _invokeMap(method, Transaction.fromMap, transaction.toMap());
  }

  static Future<Transaction?> submitCardTransaction(
      CardTransaction transaction) async {
    return _submitTransaction("card_transaction", transaction);
  }

  static Future<Transaction?> submitSTCTransaction(
      STCTransaction transaction) async {
    return _submitTransaction("stc_transaction", transaction);
  }

  static Future<Transaction?> submitTokenTransaction(
      TokenTransaction transaction) async {
    return _submitTransaction("token_transaction", transaction);
  }

  static Future<CheckoutInfo?> requestCheckoutInfo(String checkoutId) async {
    return _invokeMap(
      "checkout_info_request",
      CheckoutInfo.fromMap,
      {"checkoutId": checkoutId},
    );
  }

  static FlutterOppwaException _handleError(PlatformException exception) {
    PaymentError? error;
    if (exception.details is Map) {
      error = PaymentError.fromMap(
        (exception.details as Map).cast<String, dynamic>(),
      );
    }
    return FlutterOppwaException(
      errorCode: exception.code,
      errorMessage: exception.message,
      paymentError: error,
    );
  }
}
