part of 'flutter_oppwa.dart';

class FlutterOppwaUtils {
  FlutterOppwaUtils._();
  static String normalizeCardNumber(String card) {
    return card.replaceAll("-", "").replaceAll(" ", "");
  }

  static String normalizeHolder(String holder) {
    return holder.trim();
  }

  static String isCountryCodeValid(String holder) {
    return holder.trim();
  }

  static bool isNumberValid(String number) {
    return RegExp("[0-9]{10,19}").hasMatch(number);
  }

  static bool checkLuhn(String number) {
    if (!isNumberValid(number)) return false;
    var numbers = number.split("").reversed.map((e) => int.parse(e)).toList();
    var sum = 0;
    for (var i = 0; i < numbers.length; i++) {
      if (i % 2 != 0) {
        numbers[i] *= 2;
        if (numbers[i] > 9) numbers[i] -= 9;
      }
      sum += numbers[i];
    }
    return sum % 10 == 0;
  }

  static Future<bool> get isPlayServicesWalletAvailable async =>
      await FlutterOppwa._invoke<bool>("isPlayServicesWalletAvailable") == true;

  static Future<bool> get isPlayServicesBaseAvailable async =>
      await FlutterOppwa._invoke<bool>("isPlayServicesBaseAvailable") == true;
}
