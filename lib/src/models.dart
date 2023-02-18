import 'enums.dart';
import 'parser.dart';

class BaseTransaction {
  final String checkoutId;

  BaseTransaction({required this.checkoutId});

  Map<String, dynamic> toMap() {
    return {
      "checkoutId": checkoutId,
    };
  }
}

class CardTransaction extends BaseTransaction {
  final String number;
  final String? brand;
  final String? holder;
  final String? expiryMonth;
  final String? expiryYear;
  final String? cvv;
  final bool? tokenize;

  CardTransaction({
    required super.checkoutId,
    required this.number,
    this.brand,
    this.holder,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.tokenize,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "number": number,
      "brand": brand,
      "holder": holder,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "cvv": cvv,
      "tokenize": tokenize,
    }..removeWhere((key, value) => value == null);
  }
}

class STCTransaction extends BaseTransaction {
  final String? mobile;
  final STCPayVerificationOption verificationOption;

  STCTransaction({
    required super.checkoutId,
    required this.verificationOption,
    this.mobile,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "mobile": mobile,
      "verificationOption": verificationOption.name,
    }..removeWhere((key, value) => value == null);
  }
}

class TokenTransaction extends BaseTransaction {
  final String tokenId;
  final String brand;
  final String? cvv;

  TokenTransaction({
    required super.checkoutId,
    required this.tokenId,
    required this.brand,
    this.cvv,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "tokenId": tokenId,
      "brand": brand,
      "cvv": cvv,
    }..removeWhere((key, value) => value == null);
  }
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
  final List<Token>? tokens;

  CheckoutInfo.fromMap(Map<String, dynamic> map)
      : amount = map.getNullableValue("amount"),
        brands = map.castNullableList("brands"),
        currencyCode = map.getNullableValue("currencyCode"),
        endpoint = map.getNullableValue("endpoint"),
        klarnaMerchantIds = map.castNullableList("klarnaMerchantIds"),
        resourcePath = map.getNullableValue("resourcePath"),
        threeDs2Brands = map.castNullableList("threeDs2Brands"),
        threeDs2Flow =
            map.getNullableEnum(CheckoutThreeDS2Flow.values, "threeDs2Flow"),
        tokens = map.parseNullableList("tokens", Token.fromMap);
}

class Transaction {
  final TransactionType? transactionType;
  final Map<String, String>? brandSpecificInfo;
  final PaymentParams? paymentParams;
  final ThreeDS2Info? threeDS2Info;
  final YooKassaInfo? yooKassaInfo;
  final String? redirectUrl;
  final String? threeDS2MethodRedirectUrl;

  Transaction.fromMap(Map<String, dynamic> map)
      : transactionType =
            map.getNullableEnum(TransactionType.values, "transactionType"),
        brandSpecificInfo = map.castNullableMap("brandSpecificInfo"),
        paymentParams =
            map.parseNullableValue("paymentParams", PaymentParams.parse),
        threeDS2Info =
            map.parseNullableValue("threeDS2Info", ThreeDS2Info.fromMap),
        yooKassaInfo =
            map.parseNullableValue("yooKassaInfo", YooKassaInfo.fromMap),
        redirectUrl = map.getNullableValue("redirectUrl"),
        threeDS2MethodRedirectUrl =
            map.getNullableValue("threeDS2MethodRedirectUrl");
}

class ThreeDS2Info {
  final AuthStatus? authStatus;
  final String? authResponse;
  final String? callbackUrl;
  final String? cardHolderInfo;
  final String? challengeCompletionCallbackUrl;
  final String? protocolVersion;

  ThreeDS2Info.fromMap(Map<String, dynamic> map)
      : authStatus = map.getNullableEnum(AuthStatus.values, "authStatus"),
        authResponse = map.getNullableValue("authResponse"),
        callbackUrl = map.getNullableValue("callbackUrl"),
        cardHolderInfo = map.getNullableValue("cardHolderInfo"),
        challengeCompletionCallbackUrl =
            map.getNullableValue("challengeCompletionCallbackUrl"),
        protocolVersion = map.getNullableValue("protocolVersion");
}

class PaymentParams {
  final String? checkoutId;
  final String? paymentBrand;
  final String? shopperResultUrl;

  PaymentParams.fromMap(Map<String, dynamic> map)
      : checkoutId = map.getNullableValue("checkoutId"),
        paymentBrand = map.getNullableValue("paymentBrand"),
        shopperResultUrl = map.getNullableValue("shopperResultUrl");

  static PaymentParams parse(Map<String, dynamic> map) {
    var typename = map.getNullableValue("__typename__");
    if (typename == "CardPaymentParams") {
      return CardPaymentParams.fromMap(map);
    } else if (typename == "STCPayPaymentParams") {
      return STCPayPaymentParams.fromMap(map);
    } else if (typename == "TokenPaymentParams") {
      return TokenPaymentParams.fromMap(map);
    } else {
      return PaymentParams.fromMap(map);
    }
  }
}

class BaseCardPaymentParams extends PaymentParams {
  final String? cvv;
  final String? threeDS2AuthParams;
  final int? numberOfInstallments;

  BaseCardPaymentParams.fromMap(Map<String, dynamic> map)
      : cvv = map.getNullableValue("cvv"),
        threeDS2AuthParams = map.getNullableValue("threeDS2AuthParams"),
        numberOfInstallments = map.getNullableValue("numberOfInstallments"),
        super.fromMap(map);
}

class STCPayPaymentParams extends PaymentParams {
  final String? mobilePhoneNumber;
  final STCPayVerificationOption? verificationOption;

  STCPayPaymentParams.fromMap(Map<String, dynamic> map)
      : mobilePhoneNumber = map.getNullableValue("mobilePhoneNumber"),
        verificationOption = map.getNullableEnum(
            STCPayVerificationOption.values, "verificationOption"),
        super.fromMap(map);
}

class CardPaymentParams extends BaseCardPaymentParams {
  final String? number;
  final String? holder;
  final String? expiryMonth;
  final String? expiryYear;
  final String? mobilePhone;
  final String? countryCode;
  final BillingAddress? billingAddress;

  CardPaymentParams.fromMap(Map<String, dynamic> map)
      : number = map.getNullableValue("number"),
        holder = map.getNullableValue("holder"),
        expiryMonth = map.getNullableValue("expiryMonth"),
        expiryYear = map.getNullableValue("expiryYear"),
        mobilePhone = map.getNullableValue("mobilePhone"),
        countryCode = map.getNullableValue("countryCode"),
        billingAddress =
            map.parseNullableValue("billingAddress", BillingAddress.fromMap),
        super.fromMap(map);
}

class TokenPaymentParams extends BaseCardPaymentParams {
  final String? tokenId;

  TokenPaymentParams.fromMap(Map<String, dynamic> map)
      : tokenId = map.getNullableValue("tokenId"),
        super.fromMap(map);
}

class BillingAddress {
  final String? country;
  final String? state;
  final String? city;
  final String? postCode;
  final String? street1;
  final String? street2;

  BillingAddress.fromMap(Map<String, dynamic> map)
      : country = map.getNullableValue("country"),
        state = map.getNullableValue("state"),
        city = map.getNullableValue("city"),
        postCode = map.getNullableValue("postCode"),
        street1 = map.getNullableValue("street1"),
        street2 = map.getNullableValue("street2");
}

class YooKassaInfo {
  final YooKassaStatus? status;
  final String? confirmationUrl;
  final String? callbackUrl;

  YooKassaInfo.fromMap(Map<String, dynamic> map)
      : status = map.getNullableEnum(YooKassaStatus.values, "status"),
        confirmationUrl = map.getNullableValue("confirmationUrl"),
        callbackUrl = map.getNullableValue("callbackUrl");
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
  final ErrorCode? code;
  final String? message;
  final String? info;
  final Transaction? transaction;

  PaymentError.fromMap(Map<String, dynamic> map)
      : code = map.getNullableEnum(ErrorCode.values, "code"),
        message = map.getNullableValue("message"),
        info = map.getNullableValue("info"),
        transaction =
            map.parseNullableValue("transaction", Transaction.fromMap);
}

class Token {
  final String? tokenId;
  final String? paymentBrand;
  final BankAccount? bankAccount;
  final Card? card;
  final VirtualAccount? virtualAccount;

  Token.fromMap(Map<String, dynamic> map)
      : tokenId = map.getNullableValue("tokenId"),
        paymentBrand = map.getNullableValue("paymentBrand"),
        bankAccount =
            map.parseNullableValue("bankAccount", BankAccount.fromMap),
        card = map.parseNullableValue("card", Card.fromMap),
        virtualAccount =
            map.parseNullableValue("virtualAccount", VirtualAccount.fromMap);
}

class BankAccount {
  final String? holder;
  final String? iban;
  BankAccount.fromMap(Map<String, dynamic> map)
      : holder = map.getNullableValue("holder"),
        iban = map.getNullableValue("iban");
}

class Card {
  final String? expiryMonth;
  final String? expiryYear;
  final String? holder;
  final String? last4Digits;
  Card.fromMap(Map<String, dynamic> map)
      : expiryMonth = map.getNullableValue("expiryMonth"),
        expiryYear = map.getNullableValue("expiryYear"),
        holder = map.getNullableValue("holder"),
        last4Digits = map.getNullableValue("last4Digits");
}

class VirtualAccount {
  final String? holder;
  final String? accountId;
  VirtualAccount.fromMap(Map<String, dynamic> map)
      : holder = map.getNullableValue("holder"),
        accountId = map.getNullableValue("accountId");
}

class BrandInfo {
  final String? label;
  final String? renderType;
  final String? brand;
  final CardBrandInfo? cardBrandInfo;
  BrandInfo.fromMap(Map<String, dynamic> map)
      : label = map.getNullableValue("label"),
        renderType = map.getNullableValue("renderType"),
        brand = map.getNullableValue("brand"),
        cardBrandInfo =
            map.parseNullableValue("cardBrandInfo", CardBrandInfo.fromMap);
}

class CardBrandInfo {
  final int? cvvLength;
  final CVVMode? cvvMode;
  final String? detection;
  final String? pattern;
  final String? validation;
  CardBrandInfo.fromMap(Map<String, dynamic> map)
      : cvvLength = map.getNullableValue("cvvLength"),
        cvvMode = map.getNullableEnum(CVVMode.values, "cvvMode"),
        detection = map.getNullableValue("detection"),
        pattern = map.getNullableValue("pattern"),
        validation = map.getNullableValue("validation");
}
