import 'package:flutter/material.dart';
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
      // var status = await FlutterOppwaTest.requestPaymentStatus(
      //     "/v1/checkouts/40CD0EDDF5DF8040B79EF3BB7A6F6FB3.uat01-vm-tx04/payment");
      // return;
      var checkoutId = await FlutterOppwaTest.requestCheckoutId(9.99, "SAR",
          type: PaymentType.debit);
      // var checkoutId = "618FDDB9E8CEF6E3A761B1683012D7A2.uat01-vm-tx02";
      if (checkoutId == null) return;
      print("checkoutId: $checkoutId");
      // CF235EA2904A97E845381E95EA6856A1.uat01-vm-tx03
      var didInitialize = await FlutterOppwa.initialize(ProviderMode.test);
      if (didInitialize) {
        var checkoutInfo = await FlutterOppwa.requestCheckoutInfo(checkoutId);
        print("resourcePath: ${checkoutInfo?.resourcePath}");
        if (checkoutInfo != null && checkoutInfo.resourcePath != null) {
          // var transaction = await FlutterOppwa.submitCardTransaction(
          //   CardTransaction(
          //     checkoutId: checkoutId,
          //     // brand: "VISA",
          //     number: FlutterOppwaTest.visa3dEnrolled,
          //     holder: "Test Person",
          //     cvv: "456",
          //     expiryMonth: "10",
          //     expiryYear: "2025",
          //     tokenize: true,
          //   ),
          // );
          var transaction = await FlutterOppwa.submitSTCTransaction(
            STCTransaction(
              checkoutId: checkoutId,
              verificationOption: STCPayVerificationOption.mobilePhone,
            ),
          );
          var status = await FlutterOppwaTest.requestPaymentStatus(
              checkoutInfo.resourcePath!);
          print(status);
        }
      } else {
        print("Not Initialized");
      }
    } on FlutterOppwaException catch (e) {
      if (e.paymentError != null) {
        print("[${e.paymentError!.code}] ${e.paymentError!.message}");
      }
      print("[${e.errorCode}] ${e.errorMessage}");
    } catch (e) {
      print(e);
    }
  }
}
