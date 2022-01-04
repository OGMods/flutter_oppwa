// import 'package:pigeon/pigeon.dart';

// // flutter pub run pigeon --input pigeon/oppwa.dart --dart_out stdout/oppwa.dart --objc_header_out stdout/oppwa.h --objc_source_out stdout/oppwa.m --java_out stdout/oppwa.java

// enum ProviderMode {
//   live,
//   test,
// }

// enum TransactionType {
//   sync,
//   async,
// }
// enum YooKassaStatus {
//   succeeded,
//   pending,
//   waitingForCapture,
//   canceled,
//   undefined,
// }

// enum STCPayVerificationOption {
//   mobilePhone,
//   qrCode,
// }
// enum AuthStatus {
//   authenticated,
//   attemptProcessingPerformed,
//   challengeRequired,
//   decoupledConfirmed,
//   denied,
//   rejected,
//   failed,
//   informationalOnly,
// }

// class Transaction {
//   PaymentParams paymentParams;
//   TransactionType transactionType;
//   String? redirectUrl;
//   String? threeDS2MethodRedirectUrl;
//   ThreeDS2Info? threeDS2Info;
//   YooKassaInfo? yooKassaInfo;
//   Map<String?, String?> brandSpecificInfo;
// }

// class ThreeDS2Info {
//   AuthStatus authStatus;
//   String? authResponse;
//   // bool isChallengeRequired() => authStatus == AuthStatus.challengeRequired;
// }

// class PaymentParams {
//   String checkoutId;
//   String paymentBrand;
//   String? shopperResultUrl;
// }

// class YooKassaInfo {
//   YooKassaStatus status;
//   String? confirmationUrl;
//   String? callbackUrl;
// }

// class FlutterOppwaException {
//   String? errorCode;
//   String? errorMessage;
//   PaymentError? paymentError;
// }

// class PaymentError {
//   String? code;
//   String? message;
//   String? info;
//   Transaction? transaction;
// }

// class CardTransaction {
//   String checkoutId;
//   String number;
//   String? brand;
//   String? holder;
//   String? expiryMonth;
//   String? expiryYear;
//   String? cvv;
// }

// @HostApi()
// abstract class OppwaApi {
//   void initialize(int mode);
//   @async
//   void submitCardTransaction(CardTransaction transaction);
//   @async
//   FlutterOppwaException error();
// }
