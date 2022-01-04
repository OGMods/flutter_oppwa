enum PaymentType {
  ///A stand-alone authorisation that will also trigger optional risk management and validation. A Capture (CP) with reference to the Preauthorisation (PA) will confirm the payment..
  preauthorization,

  ///Debits the account of the end customer and credits the merchant account.
  debit,

  ///Credits the account of the end customer and debits the merchant account.
  credit,

  ///Captures a preauthorized (PA) amount.
  capture,

  ///Reverses an already processed Preauthorization (PA), Debit (DB) or Credit (CD) transaction. As a consequence, the end customer will never see any booking on his statement. A Reversal is only possible until a connector specific cut-off time. Some connectors don't support Reversals.
  reversal,

  ///Credits the account of the end customer with a reference to a prior Debit (DB) or Credit (CD) transaction. The end customer will always see two bookings on his statement. Some connectors do not support Refunds.
  refund,
}

extension PaymentTypeExtension on PaymentType {
  String get value {
    switch (this) {
      case PaymentType.preauthorization:
        return "PA";
      case PaymentType.debit:
        return "DB";
      case PaymentType.credit:
        return "CD";
      case PaymentType.capture:
        return "CP";
      case PaymentType.reversal:
        return "RV";
      case PaymentType.refund:
        return "RF";
    }
  }
}

enum CheckoutThreeDS2Flow {
  app,
  web,
  disabled,
}

enum ProviderMode {
  test,
  live,
}

enum TransactionType {
  sync,
  async,
}

enum YooKassaStatus {
  succeeded,
  pending,
  waitingForCapture,
  canceled,
  undefined,
}

enum STCPayVerificationOption {
  mobilePhone,
  qrCode,
}

enum AuthStatus {
  authenticated,
  attemptProcessingPerformed,
  challengeRequired,
  decoupledConfirmed,
  denied,
  rejected,
  failed,
  informationalOnly,
}
