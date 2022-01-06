import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_oppwa/flutter_oppwa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: IconButton(
            icon: const Icon(Icons.play_arrow),
            onPressed: _testCall,
          ),
        ),
      ),
    );
  }

  void _testCall() async {
    //https://wordpresshyperpay.docs.oppwa.com/reference/resultCodes

    //https://github.com/nyartech/hyperpay/blob/main/android/src/main/kotlin/com/nyartech/hyperpay/HyperpayPlugin.kt
    //https://wordpresshyperpay.docs.oppwa.com/reference/parameters#testing
    //https://peachpayments.docs.oppwa.com/msdk/ios-docs/
    //https://peachpayments.docs.oppwa.com/msdk/android-docs/index.html
    //https://wordpresshyperpay.docs.oppwa.com/tutorials/mobile-sdk/custom-ui/asynchronous-payments
    //https://github.com/cph-cachet/flutter-plugins/blob/master/packages/esense_flutter/ios/Classes/SwiftEsenseFlutterPlugin.swift
    try {
      // var checkoutId =
      //     await FlutterOppwa.getTestCheckoutId(19, "USD", PaymentType.debit);
      // print("checkoutId: $checkoutId");
      // if (checkoutId == null) return;
      var result1 = await FlutterOppwa.initialize(ProviderMode.test);
      print(result1);
      // var result2 = await FlutterOppwa.requestCheckoutInfo(checkoutId);
      // print(result2?.toMap());
      // if (result2 != null && result2.resourcePath != null) {
      //   //  var result3 = await FlutterOppwa.submitCardTransaction(CardTransaction(
      //   //   checkoutId: checkoutId,
      //   //   brand: "VISA",
      //   //   number: FlutterOppwa.visa3dEnrolled,
      //   //   holder: "Test Person",
      //   //   cvv: "456",
      //   //   expiryMonth: "10",
      //   //   expiryYear: "2022",
      //   //   tokenize: true,
      //   // ));
      //   // print(result3?.toMap());
      //   var result4 =
      //       await FlutterOppwa.requestTestPaymentStatus(result2.resourcePath!);
      //   print(result4);
      // }
    } on FlutterOppwaException catch (e) {
      if (e.paymentError != null) {
        print("[${e.paymentError!.code}] ${e.paymentError!.message}");
      }
      print("[${e.errorCode}] ${e.errorMessage}");
    }
  }
}
