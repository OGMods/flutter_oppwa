import 'enums.dart';

List<String>? _parseList(dynamic value) {
  if (value != null) {
    return value.toString().split("_flutter-oppwa_");
  }
}

Map<String, dynamic>? _parseMap(dynamic value) {
  if (value != null && value is Map<Object?, Object?>) {
    return value.cast<String, dynamic>();
  }
}

T? _parseMapTo<T>(dynamic value, T Function(Map<String, dynamic> map) parser) {
  var map = _parseMap(value);
  if (map != null) return parser(map);
}

class CheckoutInfo {
  final double? amount;
  final List<String>? brands;
  final String? currencyCode;
  final String? endpoint;
  final List<String>? klarnaMerchantIds;
  final String? resourcePath;
  final List<String>? threeDs2Brands;
  final CheckoutThreeDS2Flow? threeDs2Flow;
  final String? tokens;
  CheckoutInfo({
    this.amount,
    this.brands,
    this.currencyCode,
    this.endpoint,
    this.klarnaMerchantIds,
    this.resourcePath,
    this.threeDs2Brands,
    this.threeDs2Flow,
    this.tokens,
  });

  factory CheckoutInfo.fromMap(Map<Object?, Object?> map) {
    return CheckoutInfo(
      amount: double.tryParse((map['endpoint'] as String?) ?? ""),
      brands: _parseList(map['brands']),
      currencyCode: map['currencyCode'] as String?,
      endpoint: map['endpoint'] as String?,
      klarnaMerchantIds: _parseList(map['klarnaMerchantIds']),
      resourcePath: map['resourcePath'] as String?,
      threeDs2Brands: _parseList(map['threeDs2Brands']),
      threeDs2Flow: map['threeDs2Flow'] != null
          ? CheckoutThreeDS2Flow.values[map['threeDs2Flow']! as int]
          : null,
      tokens: map['tokens'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "brands": brands,
      "currencyCode": currencyCode,
      "endpoint": endpoint,
      "klarnaMerchantIds": klarnaMerchantIds,
      "resourcePath": resourcePath,
      "threeDs2Brands": threeDs2Brands,
      "threeDs2Flow": threeDs2Flow?.name,
      "tokens": tokens,
    };
  }
}

class Transaction {
  final PaymentParams? paymentParams;
  final TransactionType? transactionType;
  final String? redirectUrl;
  final String? threeDS2MethodRedirectUrl;
  final ThreeDS2Info? threeDS2Info;
  final YooKassaInfo? yooKassaInfo;
  final Map<String, String>? brandSpecificInfo;

  Transaction({
    this.paymentParams,
    this.transactionType,
    this.redirectUrl,
    this.threeDS2MethodRedirectUrl,
    this.threeDS2Info,
    this.yooKassaInfo,
    this.brandSpecificInfo,
  });

  factory Transaction.fromMap(Map<Object?, Object?> map) {
    return Transaction(
      paymentParams: _parseMapTo(
          map['paymentParams'], (map) => PaymentParams.fromMap(map)),
      transactionType: map['transactionType'] != null
          ? TransactionType.values[map['transactionType']! as int]
          : null,
      redirectUrl: map['redirectUrl'] as String?,
      threeDS2MethodRedirectUrl: map['threeDS2MethodRedirectUrl'] as String?,
      threeDS2Info:
          _parseMapTo(map['threeDS2Info'], (map) => ThreeDS2Info.fromMap(map)),
      yooKassaInfo:
          _parseMapTo(map['yooKassaInfo'], (map) => YooKassaInfo.fromMap(map)),
      brandSpecificInfo: (map['brandSpecificInfo'] as Map<Object?, Object?>?)
          ?.cast<String, String>(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "paymentParams": paymentParams?.toMap(),
      "transactionType": transactionType?.name,
      "redirectUrl": redirectUrl,
      "threeDS2MethodRedirectUrl": threeDS2MethodRedirectUrl,
      "threeDS2Info": threeDS2Info?.toMap(),
      "yooKassaInfo": yooKassaInfo?.toMap(),
      "brandSpecificInfo": brandSpecificInfo,
    };
  }
}

class ThreeDS2Info {
  final AuthStatus? authStatus;
  final String? authResponse;

  ThreeDS2Info({this.authStatus, this.authResponse});

  factory ThreeDS2Info.fromMap(Map<Object?, Object?> map) {
    return ThreeDS2Info(
      authStatus: map['authStatus'] != null
          ? AuthStatus.values[map['authStatus']! as int]
          : null,
      authResponse: map['authResponse'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "authStatus": authStatus?.name,
      "authResponse": authResponse,
    };
  }
}

class PaymentParams {
  final String? checkoutId;
  final String? paymentBrand;
  final String? shopperResultUrl;

  PaymentParams({this.checkoutId, this.paymentBrand, this.shopperResultUrl});

  factory PaymentParams.fromMap(Map<Object?, Object?> map) {
    return PaymentParams(
      checkoutId: map['checkoutId'] as String?,
      paymentBrand: map['paymentBrand'] as String?,
      shopperResultUrl: map['shopperResultUrl'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "checkoutId": checkoutId,
      "paymentBrand": paymentBrand,
      "shopperResultUrl": shopperResultUrl,
    };
  }
}

class YooKassaInfo {
  final YooKassaStatus? status;
  final String? confirmationUrl;
  final String? callbackUrl;

  YooKassaInfo({this.status, this.confirmationUrl, this.callbackUrl});

  factory YooKassaInfo.fromMap(Map<Object?, Object?> map) {
    return YooKassaInfo(
      status: map['status'] != null
          ? YooKassaStatus.values[map['status']! as int]
          : null,
      confirmationUrl: map['confirmationUrl'] as String?,
      callbackUrl: map['callbackUrl'] as String?,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "status": status?.name,
      "confirmationUrl": confirmationUrl,
      "callbackUrl": callbackUrl,
    };
  }
}

class FlutterOppwaException {
  final String errorCode;
  final String? errorMessage;
  final PaymentError? paymentError;

  FlutterOppwaException({
    required this.errorCode,
    this.errorMessage,
    this.paymentError,
  });
}

class PaymentError {
  final String? code;
  final String? message;
  final String? info;
  final Transaction? transaction;

  PaymentError({this.code, this.message, this.info, this.transaction});

  factory PaymentError.fromMap(Map<Object?, Object?> map) {
    return PaymentError(
      code: map['code'] as String?,
      message: map['message'] as String?,
      info: map['info'] as String?,
      transaction:
          _parseMapTo(map['transaction'], (map) => Transaction.fromMap(map)),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "code": code,
      "message": message,
      "info": info,
      "transaction": transaction?.toMap(),
    };
  }
}

class CardTransaction {
  final String checkoutId;
  final String number;
  final String? brand;
  final String? holder;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cvv;
  final bool? tokenize;

  CardTransaction({
    required this.checkoutId,
    required this.number,
    this.brand,
    this.holder,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.tokenize,
  });

  Map<String, dynamic> toMap() {
    return {
      "checkoutId": checkoutId,
      "number": number,
      "brand": brand,
      "holder": holder,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "cvv": cvv,
      "tokenize": tokenize,
    };
  }
}
