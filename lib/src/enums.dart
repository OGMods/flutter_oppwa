enum PaymentType {
  ///A stand-alone authorisation that will also trigger optional risk management and validation. A Capture (CP) with reference to the Preauthorisation (PA) will confirm the payment..
  preauthorization("PA"),

  ///Debits the account of the end customer and credits the merchant account.
  debit("DB"),

  ///Credits the account of the end customer and debits the merchant account.
  credit("CD"),

  ///Captures a preauthorized (PA) amount.
  capture("CP"),

  ///Reverses an already processed Preauthorization (PA), Debit (DB) or Credit (CD) transaction. As a consequence, the end customer will never see any booking on his statement. A Reversal is only possible until a connector specific cut-off time. Some connectors don't support Reversals.
  reversal("RV"),

  ///Credits the account of the end customer with a reference to a prior Debit (DB) or Credit (CD) transaction. The end customer will always see two bookings on his statement. Some connectors do not support Refunds.
  refund("RF");

  final String value;
  const PaymentType(this.value);
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

enum CVVMode {
  none,
  optional,
  required,
}

enum ErrorCode {
  errorCodePaymentParamsInvalid,
  errorCodePaymentParamsCheckoutIdInvalid,
  errorCodePaymentParamsPaymentBrandInvalid,
  errorCodePaymentParamsTokenInvalid,
  errorCodePaymentParamsTokenizationUnsupported,
  errorCodePaymentParamsCardHolderInvalid,
  errorCodePaymentParamsCardNumberInvalid,
  errorCodePaymentParamsCardBrandInvalid,
  errorCodePaymentParamsCardMonthInvalid,
  errorCodePaymentParamsCardYearInvalid,
  errorCodePaymentParamsCardExpired,
  errorCodePaymentParamsCardCvvInvalid,
  errorCodePaymentParamsBankAccountHolderInvalid,
  errorCodePaymentParamsBankAccountIbanInvalid,
  errorCodePaymentParamsBankAccountCountryInvalid,
  errorCodePaymentParamsBankAccountBankNameInvalid,
  errorCodePaymentParamsBankAccountNumberInvalid,
  errorCodePaymentParamsBankAccountBicInvalid,
  errorCodePaymentParamsBankAccountBankCodeInvalid,
  errorCodePaymentParamsMobilePhoneInvalid,
  errorCodePaymentParamsCountryCodeInvalid,
  errorCodePaymentParamsEmailInvalid,
  errorCodePaymentParamsNationalIdentifierInvalid,
  errorCodePaymentParamsAccountVerificationInvalid,
  errorCodePaymentParamsPaymentTokenMissing,
  errorCodePaymentProviderNotInitialized,
  errorCodePaymentProviderInternalError,
  errorCodePaymentProviderSecurityInvalidChecksum,
  errorCodePaymentProviderSecuritySslValidationFailed,
  errorCodePaymentProviderConnectionFailure,
  errorCodePaymentProviderConnectionMalformedResponse,
  errorCodeNoAvailablePaymentMethods,
  errorCodePaymentMethodNotAvailable,
  errorCodeCheckoutSettingsMissed,
  errorCodeTransactionAborted,
  errorCodeUnexpectedException,
  errorCodeGooglepay,
  errorCodeKlarnaInline,
  errorCodeBancontactLink,
  errorCodeThreeds2Failed,
  errorCodeThreeds2Canceled,
}
