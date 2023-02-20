import 'dart:typed_data';

import 'package:flutter_oppwa/flutter_oppwa.dart';

class BaseTransaction {
  /// The checkout id of the transaction. Must not be empty.
  final String checkoutId;

  BaseTransaction._(this.checkoutId)
      : assert(
            checkoutId.trim().isNotEmpty, "The checkout id must not be empty");

  Map<String, dynamic> toMap() {
    return {
      "checkoutId": checkoutId,
    };
  }
}

/// Class to represent a set of card parameters needed for performing an e-commerce card transaction.
///
/// It offers convenience methods for checking if the number is valid, i.e. if it passes the Luhn check and can be assigned to one of the major card companies.
///
/// Will become [CardPaymentParams] when it comes back from the native side
class CardTransaction extends BaseTransaction {
  /// The card number of the transaction.
  final String number;

  /// The payment brand of the card.
  final String? brand;

  /// The name of the card holder.
  final String? holder;

  /// The expiration year. It is expected in the format `YYYY`.
  final String? expiryMonth;

  /// The expiration month of the card. It is expected in the format `MM`.
  final String? expiryYear;

  /// The CVV code associated with the card. Set to `null` if CVV is not required.
  final String? cvv;

  /// If the payment information should be stored for future use.
  final bool? tokenize;

  /// [checkoutId] The checkout id of the transaction. Must not be empty.
  ///
  /// [number] The card number of the transaction.
  ///
  /// [brand] The payment brand of the card.
  ///
  /// [holder] The name of the card holder.
  ///
  /// [expiryMonth] The expiration year. It is expected in the format `YYYY`.
  ///
  /// [expiryYear] The expiration month of the card. It is expected in the format `MM`.
  ///
  /// [cvv] The CVV code associated with the card. Set to `null` if CVV is not required.
  ///
  /// [tokenize] If the payment information should be stored for future use.
  CardTransaction({
    required String checkoutId,
    required this.number,
    this.brand,
    this.holder,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.tokenize,
  }) : super._(checkoutId);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "type": "card",
      "number": number,
      "brand": brand,
      "holder": holder,
      "expiryMonth": expiryMonth,
      "expiryYear": expiryYear,
      "cvv": cvv,
      "tokenize": tokenize,
    }..removeWhere((key, value) => value == null);
  }

  /// Checks if the [holder] name is filled with sufficient data to perform a transaction.
  ///
  /// Returns true if the holder name length greater than 3 characters and less than 128 character.
  static bool isHolderValid(String holder) {
    return holder.length > 3 && holder.length < 128;
  }

  /// Checks if the card [number] is filled with sufficient data to perform a transaction.
  ///
  /// If the [luhnCheck] is set to true, the [number] should pass Luhn test http://en.wikipedia.org/wiki/Luhn_algorithm.
  ///
  /// Returns true if the number consists of 10-19 digits and passes luhn test
  static bool isNumberValid(String number, bool luhnCheck) {
    // TODO
    return true;
  }

  /// Checks if the card [expiryMonth] is filled with sufficient data to perform a transaction.
  ///
  /// Returns true if the card expiry month is in the format `MM`.
  static bool isExpiryMonthValid(String expiryMonth) {
    var month = int.tryParse(expiryMonth);
    return expiryMonth.length == 2 &&
        month != null &&
        month >= 1 &&
        month <= 12;
  }

  /// Checks if the card [expiryYear] is filled with sufficient data to perform a transaction.
  ///
  /// Returns true if the card expiry year is in the format `YYYY`.
  static bool isExpiryYearValid(String expiryYear) {
    var year = int.tryParse(expiryYear);
    return expiryYear.length == 4 && year != null;
  }

  /// Checks if the [countryCode] is filled with sufficient data to perform a transaction.
  ///
  /// Returns true if the country code contains digits only.
  static bool isCountryCodeValid(String countryCode) {
    // TODO
    return true;
  }

  /// Checks if the [mobilePhone] is filled with sufficient data to perform a transaction.
  ///
  /// Returns true if the mobile phone number contains digits only.
  static bool isMobilePhoneValid(String mobilePhone) {
    // TODO
    return true;
  }

  /// Checks if the [month] and [year] have been set and whether or not card is expired.
  ///
  /// Returns true if the month or the year is expired.
  static bool isExpiredWithExpiryMonth(String month, String year) {
    if (isExpiryMonthValid(month) && isExpiryYearValid(year)) {
      var m = int.tryParse(month);
      var y = int.tryParse(year);
      var n = DateTime.now();
      if (m != null && y != null) {
        return y > n.year || (y == n.year && m >= n.month);
      }
    }
    return true;
  }
}

/// Class to represent all necessary transaction parameters for performing an STC Pay transaction.
///
/// Will become [STCPayPaymentParams] when it comes back from the native side
class STCTransaction extends BaseTransaction {
  /// The mobile phone number.
  final String? mobile;

  /// The verification option to proceed STC Pay transaction
  final STCPayVerificationOption verificationOption;

  /// [checkoutId] The checkout id of the transaction. Must not be empty.
  ///
  /// [verificationOption] The card number of the transaction.
  ///
  /// [mobile] The mobile phone number.
  STCTransaction({
    required String checkoutId,
    required this.verificationOption,
    this.mobile,
  }) : super._(checkoutId);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "type": "stc",
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
    required String checkoutId,
    required this.tokenId,
    required this.brand,
    this.cvv,
  }) : super._(checkoutId);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "type": "token",
      "tokenId": tokenId,
      "brand": brand,
      "cvv": cvv,
    }..removeWhere((key, value) => value == null);
  }
}

/// Class to represent all necessary transaction parameters for performing an Apple Pay transaction.
///
/// Will become [ApplePayPaymentParams] when it comes back from the native side
class AppleTransaction extends BaseTransaction {
  /// UTF-8 encoded JSON dictionary of encrypted payment data.  Ready for transmission to merchant's e-commerce backend for decryption and submission to a payment processor's gateway.
  final Uint8List tokenData;

  /// [checkoutId] The checkout id of the transaction. Must not be empty.
  ///
  /// [tokenData] UTF-8 encoded JSON dictionary of encrypted payment data.
  AppleTransaction({
    required String checkoutId,
    required this.tokenData,
  }) : super._(checkoutId);

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      "type": "apple",
      "tokenData": tokenData,
    }..removeWhere((key, value) => value == null);
  }
}


// class BrandInfo {
//   final String? label;
//   final String? renderType;
//   final String? brand;
//   final CardBrandInfo? cardBrandInfo;
//   BrandInfo.fromMap(Map<String, dynamic> map)
//       : label = map.getNullableValue("label"),
//         renderType = map.getNullableValue("renderType"),
//         brand = map.getNullableValue("brand"),
//         cardBrandInfo =
//             map.parseNullableValue("cardBrandInfo", CardBrandInfo.fromMap);
// }

// class CardBrandInfo {
//   final int? cvvLength;
//   final CVVMode? cvvMode;
//   final String? detection;
//   final String? pattern;
//   final String? validation;
//   CardBrandInfo.fromMap(Map<String, dynamic> map)
//       : cvvLength = map.getNullableValue("cvvLength"),
//         cvvMode = map.getNullableEnum(CVVMode.values, "cvvMode"),
//         detection = map.getNullableValue("detection"),
//         pattern = map.getNullableValue("pattern"),
//         validation = map.getNullableValue("validation");
// }
