package net.ogmods.flutter_oppwa;

import androidx.annotation.Nullable;

import com.oppwa.mobile.connect.checkout.meta.CheckoutThreeDS2Flow;
import com.oppwa.mobile.connect.exception.ErrorCode;
import com.oppwa.mobile.connect.payment.CVVMode;
import com.oppwa.mobile.connect.payment.stcpay.STCPayVerificationOption;
import com.oppwa.mobile.connect.provider.Connect;
import com.oppwa.mobile.connect.provider.ThreeDS2Info;
import com.oppwa.mobile.connect.provider.TransactionType;
import com.oppwa.mobile.connect.provider.model.yookassa.YooKassaStatus;

public class FlutterEnums {
    public interface FlutterEnum<T> {
        T getValue();
    }

    @Nullable
    public static <T, K extends Enum<K> & FlutterEnum<T>> String toJson(K[] values, @Nullable T value) {
        if(value == null) return null;
        for (K e : values) if (e.getValue().equals(value)) return e.name();
        return null;
    }

    @Nullable
    public static <T, K extends Enum<K> & FlutterEnum<T>> K find(K[] values, @Nullable T value) {
        if(value == null) return null;
        for (K e : values) if (e.getValue().equals(value)) return e;
        return null;
    }

    @Nullable
    public static <K extends Enum<K>> K find(K[] values, @Nullable String value) {
        if(value == null) return null;
        for (K e : values) if (e.name().equals(value)) return e;
        return null;
    }

    public enum FlutterProviderDomain implements FlutterEnum<Connect.ProviderDomain> {
        defaultDomain(Connect.ProviderDomain.DEFAULT),
        euDomain(Connect.ProviderDomain.EU);

        private final Connect.ProviderDomain value;

        FlutterProviderDomain(final Connect.ProviderDomain value) {
            this.value = value;
        }

        @Override
        public Connect.ProviderDomain getValue() {
            return this.value;
        }
    }

    public enum FlutterProviderMode implements FlutterEnum<Connect.ProviderMode> {
        test(Connect.ProviderMode.TEST),
        live(Connect.ProviderMode.LIVE);

        private final Connect.ProviderMode value;

        FlutterProviderMode(final Connect.ProviderMode value) {
            this.value = value;
        }

        @Override
        public Connect.ProviderMode getValue() {
            return this.value;
        }
    }

    public enum FlutterSTCPayVerificationOption implements FlutterEnum<STCPayVerificationOption> {
        mobilePhone(STCPayVerificationOption.MOBILE_PHONE),
        qrCode(STCPayVerificationOption.QR_CODE);

        private final STCPayVerificationOption value;

        FlutterSTCPayVerificationOption(final STCPayVerificationOption value) {
            this.value = value;
        }

        @Override
        public STCPayVerificationOption getValue() {
            return this.value;
        }
    }

    public enum FlutterTransactionType implements FlutterEnum<TransactionType> {
        sync(TransactionType.SYNC),
        async(TransactionType.ASYNC);

        private final TransactionType value;

        FlutterTransactionType(final TransactionType value) {
            this.value = value;
        }

        @Override
        public TransactionType getValue() {
            return this.value;
        }
    }

    public enum FlutterCheckoutThreeDS2Flow implements FlutterEnum<CheckoutThreeDS2Flow> {
        app(CheckoutThreeDS2Flow.APP),
        web(CheckoutThreeDS2Flow.WEB),
        disabled(CheckoutThreeDS2Flow.DISABLED);

        private final CheckoutThreeDS2Flow value;

        FlutterCheckoutThreeDS2Flow(final CheckoutThreeDS2Flow value) {
            this.value = value;
        }

        @Override
        public CheckoutThreeDS2Flow getValue() {
            return this.value;
        }
    }

    public enum FlutterYooKassaStatus implements FlutterEnum<YooKassaStatus> {
        succeeded(YooKassaStatus.SUCCEEDED),
        pending(YooKassaStatus.PENDING),
        waitingForCapture(YooKassaStatus.WAITING_FOR_CAPTURE),
        canceled(YooKassaStatus.CANCELED),
        undefined(YooKassaStatus.UNDEFINED);

        private final YooKassaStatus value;

        FlutterYooKassaStatus(final YooKassaStatus value) {
            this.value = value;
        }

        @Override
        public YooKassaStatus getValue() {
            return this.value;
        }
    }

    public enum FlutterAuthStatus implements FlutterEnum<ThreeDS2Info.AuthStatus> {
        authenticated(ThreeDS2Info.AuthStatus.AUTHENTICATED),
        attemptProcessingPerformed(ThreeDS2Info.AuthStatus.ATTEMPT_PROCESSING_PERFORMED),
        challengeRequired(ThreeDS2Info.AuthStatus.CHALLENGE_REQUIRED),
        decoupledConfirmed(ThreeDS2Info.AuthStatus.DECOUPLED_CONFIRMED),
        denied(ThreeDS2Info.AuthStatus.DENIED),
        rejected(ThreeDS2Info.AuthStatus.REJECTED),
        failed(ThreeDS2Info.AuthStatus.FAILED),
        informationalOnly(ThreeDS2Info.AuthStatus.INFORMATIONAL_ONLY);

        private final ThreeDS2Info.AuthStatus value;

        FlutterAuthStatus(final ThreeDS2Info.AuthStatus value) {
            this.value = value;
        }

        @Override
        public ThreeDS2Info.AuthStatus getValue() {
            return this.value;
        }
    }
    public enum FlutterCVVMode implements FlutterEnum<CVVMode> {
        none(CVVMode.NONE),
        optional(CVVMode.OPTIONAL),
        required(CVVMode.REQUIRED);

        private final CVVMode value;

        FlutterCVVMode(final CVVMode value) {
            this.value = value;
        }

        @Override
        public CVVMode getValue() {
            return this.value;
        }
    }
    public enum FlutterErrorCode implements FlutterEnum<ErrorCode> {
        errorCodePaymentParamsInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_INVALID),
        errorCodePaymentParamsCheckoutIdInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CHECKOUT_ID_INVALID),
        errorCodePaymentParamsPaymentBrandInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_PAYMENT_BRAND_INVALID),
        errorCodePaymentParamsTokenInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_TOKEN_INVALID),
        errorCodePaymentParamsTokenizationUnsupported(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_TOKENIZATION_UNSUPPORTED),
        errorCodePaymentParamsCardHolderInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_HOLDER_INVALID),
        errorCodePaymentParamsCardNumberInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_NUMBER_INVALID),
        errorCodePaymentParamsCardBrandInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_BRAND_INVALID),
        errorCodePaymentParamsCardMonthInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_MONTH_INVALID),
        errorCodePaymentParamsCardYearInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_YEAR_INVALID),
        errorCodePaymentParamsCardExpired(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_EXPIRED),
        errorCodePaymentParamsCardCvvInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_CARD_CVV_INVALID),
        errorCodePaymentParamsBankAccountHolderInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_HOLDER_INVALID),
        errorCodePaymentParamsBankAccountIbanInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_IBAN_INVALID),
        errorCodePaymentParamsBankAccountCountryInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_COUNTRY_INVALID),
        errorCodePaymentParamsBankAccountBankNameInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_BANK_NAME_INVALID),
        errorCodePaymentParamsBankAccountNumberInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_NUMBER_INVALID),
        errorCodePaymentParamsBankAccountBicInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_BIC_INVALID),
        errorCodePaymentParamsBankAccountBankCodeInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_BANK_ACCOUNT_BANK_CODE_INVALID),
        errorCodePaymentParamsMobilePhoneInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_MOBILE_PHONE_INVALID),
        errorCodePaymentParamsCountryCodeInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_COUNTRY_CODE_INVALID),
        errorCodePaymentParamsEmailInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_EMAIL_INVALID),
        errorCodePaymentParamsNationalIdentifierInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_NATIONAL_IDENTIFIER_INVALID),
        errorCodePaymentParamsAccountVerificationInvalid(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_ACCOUNT_VERIFICATION_INVALID),
        errorCodePaymentParamsPaymentTokenMissing(ErrorCode.ERROR_CODE_PAYMENT_PARAMS_PAYMENT_TOKEN_MISSING),
        errorCodePaymentProviderNotInitialized(ErrorCode.ERROR_CODE_PAYMENT_PROVIDER_NOT_INITIALIZED),
        errorCodePaymentProviderInternalError(ErrorCode.ERROR_CODE_PAYMENT_PROVIDER_INTERNAL_ERROR),
        errorCodePaymentProviderSecurityInvalidChecksum(ErrorCode.ERROR_CODE_PAYMENT_PROVIDER_SECURITY_INVALID_CHECKSUM),
        errorCodePaymentProviderSecuritySslValidationFailed(ErrorCode.ERROR_CODE_PAYMENT_PROVIDER_SECURITY_SSL_VALIDATION_FAILED),
        errorCodePaymentProviderConnectionFailure(ErrorCode.ERROR_CODE_PAYMENT_PROVIDER_CONNECTION_FAILURE),
        errorCodePaymentProviderConnectionMalformedResponse(ErrorCode.ERROR_CODE_PAYMENT_PROVIDER_CONNECTION_MALFORMED_RESPONSE),
        errorCodeNoAvailablePaymentMethods(ErrorCode.ERROR_CODE_NO_AVAILABLE_PAYMENT_METHODS),
        errorCodePaymentMethodNotAvailable(ErrorCode.ERROR_CODE_PAYMENT_METHOD_NOT_AVAILABLE),
        errorCodeCheckoutSettingsMissed(ErrorCode.ERROR_CODE_CHECKOUT_SETTINGS_MISSED),
        errorCodeTransactionAborted(ErrorCode.ERROR_CODE_TRANSACTION_ABORTED),
        errorCodeUnexpectedException(ErrorCode.ERROR_CODE_UNEXPECTED_EXCEPTION),
        errorCodeGooglepay(ErrorCode.ERROR_CODE_GOOGLEPAY),
        errorCodeKlarnaInline(ErrorCode.ERROR_CODE_KLARNA_INLINE),
        errorCodeBancontactLink(ErrorCode.ERROR_CODE_BANCONTACT_LINK),
        errorCodeThreeds2Failed(ErrorCode.ERROR_CODE_THREEDS2_FAILED),
        errorCodeThreeds2Canceled(ErrorCode.ERROR_CODE_THREEDS2_CANCELED);

        private final ErrorCode value;

        FlutterErrorCode(final ErrorCode value) {
            this.value = value;
        }

        @Override
        public ErrorCode getValue() {
            return this.value;
        }
    }
}
