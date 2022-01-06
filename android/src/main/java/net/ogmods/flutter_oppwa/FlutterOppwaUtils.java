package net.ogmods.flutter_oppwa;

import android.app.Activity;
import android.text.TextUtils;

import com.oppwa.mobile.connect.checkout.meta.CheckoutThreeDS2Flow;
import com.oppwa.mobile.connect.exception.PaymentError;
import com.oppwa.mobile.connect.exception.PaymentException;
import com.oppwa.mobile.connect.payment.CheckoutInfo;
import com.oppwa.mobile.connect.payment.PaymentParams;
import com.oppwa.mobile.connect.payment.card.CardPaymentParams;
import com.oppwa.mobile.connect.payment.stcpay.STCPayPaymentParams;
import com.oppwa.mobile.connect.payment.stcpay.STCPayVerificationOption;
import com.oppwa.mobile.connect.provider.Connect;
import com.oppwa.mobile.connect.provider.ThreeDS2Info;
import com.oppwa.mobile.connect.provider.Transaction;
import com.oppwa.mobile.connect.provider.TransactionType;
import com.oppwa.mobile.connect.provider.model.yookassa.YooKassaInfo;
import com.oppwa.mobile.connect.provider.model.yookassa.YooKassaStatus;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import androidx.annotation.NonNull;
import androidx.browser.customtabs.CustomTabsClient;

class FlutterOppwaUtils {
    public static String getPackageName(Activity activity) {
        return CustomTabsClient.getPackageName(activity, Collections.singletonList("com.android.chrome"));
    }

    public static String join(@NonNull Object[] tokens) {
        return TextUtils.join("_flutter-oppwa_", tokens);
    }

    public static Map<String, Object> convertPaymentExceptionToMap(PaymentException error) {
        return convertPaymentErrorToMap(error.getError());
    }

    public static Map<String, Object> convertPaymentErrorToMap(PaymentError error) {
        Map<String, Object> map = new HashMap<>();
        map.put("code", error.getErrorCode().name());
        map.put("message", error.getErrorMessage());
        map.put("info", error.getErrorInfo());
        return map;
    }

    public static Map<String, Object> convertTransactionToMap(Transaction transaction) {
        Map<String, Object> map = new HashMap<>();
        map.put("transactionType", FlutterTransactionType.findIndex(transaction.getTransactionType()));
        map.put("brandSpecificInfo", transaction.getBrandSpecificInfo());
        map.put("paymentParams", convertPaymentParamsToMap(transaction.getPaymentParams()));
        ThreeDS2Info threeDS2Info = transaction.getThreeDS2Info();
        YooKassaInfo yooKassaInfo = transaction.getYooKassaInfo();
        if (threeDS2Info != null) map.put("threeDS2Info", convertThreeDS2InfoToMap(threeDS2Info));
        if (yooKassaInfo != null) map.put("yooKassaInfo", convertYooKassaInfoToMap(yooKassaInfo));
        if (transaction.getRedirectUrl() != null) map.put("redirectUrl", transaction.getRedirectUrl());
        if (transaction.getThreeDS2MethodRedirectUrl() != null) map.put("threeDS2MethodRedirectUrl", transaction.getThreeDS2MethodRedirectUrl());

        return map;
    }

    public static Map<String, Object> convertPaymentParamsToMap(PaymentParams params) {
        Map<String, Object> map = new HashMap<>();
        if (params.getClass() == CardPaymentParams.class) {
            map.put("number", ((CardPaymentParams) params).getNumber());
            map.put("expiryMonth", ((CardPaymentParams) params).getExpiryMonth());
            map.put("expiryYear", ((CardPaymentParams) params).getExpiryYear());
            map.put("cvv", ((CardPaymentParams) params).getCvv());
            map.put("holder", ((CardPaymentParams) params).getHolder());
            map.put("countryCode", ((CardPaymentParams) params).getCountryCode());
            map.put("mobilePhone", ((CardPaymentParams) params).getMobilePhone());
        } else if (params.getClass() == STCPayPaymentParams.class) {
            map.put("mobilePhoneNumber", ((STCPayPaymentParams) params).getMobilePhoneNumber());
            map.put("verificationOption", FlutterSTCPayVerificationOption.findIndex(((STCPayPaymentParams) params).getVerificationOption()));
        }
        // TODO: handle other types of payment params
        map.put("checkoutId", params.getCheckoutId());
        map.put("paymentBrand", params.getPaymentBrand());
        if (params.getShopperResultUrl() != null) map.put("shopperResultUrl", params.getShopperResultUrl());

        return map;
    }

    public static Map<String, Object> convertThreeDS2InfoToMap(ThreeDS2Info info) {
        Map<String, Object> map = new HashMap<>();
        map.put("authStatus", FlutterAuthStatus.findIndex(info.getAuthStatus()));
        if (info.getAuthResponse() != null) map.put("authResponse", info.getAuthResponse());
        return map;
    }

    public static Map<String, Object> convertYooKassaInfoToMap(YooKassaInfo info) {
        Map<String, Object> map = new HashMap<>();
        map.put("status", FlutterYooKassaStatus.findIndex(info.getStatus()));
        if (info.getConfirmationUrl() != null) map.put("confirmationUrl", info.getConfirmationUrl());
        if (info.getCallbackUrl() != null) map.put("callbackUrl", info.getCallbackUrl());
        return map;
    }

    public static Map<String, Object> convertCheckoutInfoToMap(CheckoutInfo info) {
        Map<String, Object> map = new HashMap<>();
        map.put("amount", Double.toString(info.getAmount()));
        if (info.getBrands() != null) map.put("brands", join(info.getBrands()));
        if (info.getCurrencyCode() != null) map.put("currencyCode", info.getCurrencyCode());
        if (info.getEndpoint() != null) map.put("endpoint", info.getEndpoint());
        if (info.getKlarnaMerchantIds() != null) map.put("klarnaMerchantIds", join(info.getKlarnaMerchantIds()));
        if (info.getResourcePath() != null) map.put("resourcePath", info.getResourcePath());
        if (info.getThreeDS2Brands() != null) map.put("threeDs2Brands", join(info.getThreeDS2Brands()));
        if (info.getThreeDS2Flow() != null) map.put("threeDs2Flow", FlutterCheckoutThreeDS2Flow.findIndex(info.getThreeDS2Flow()));
        //TODO: convert token to map
        //if (info.getTokens() != null) map.put("tokens", info.getTokens());
        return map;
    }

    public enum FlutterProviderMode {
        test(0, Connect.ProviderMode.TEST),
        live(1, Connect.ProviderMode.LIVE);

        private final int index;
        private final Connect.ProviderMode value;

        FlutterProviderMode(final int index, final Connect.ProviderMode value) {
            this.index = index;
            this.value = value;
        }

        public static Connect.ProviderMode fromIndex(int index) {
            for (FlutterProviderMode e : values()) {
                if (e.index == index) return e.value;
            }
            return null;
        }
    }

    public enum FlutterSTCPayVerificationOption {
        mobilePhone(0, STCPayVerificationOption.MOBILE_PHONE),
        qrCode(1, STCPayVerificationOption.QR_CODE);

        private final int index;
        private final STCPayVerificationOption value;

        FlutterSTCPayVerificationOption(final int index, final STCPayVerificationOption value) {
            this.index = index;
            this.value = value;
        }

        public static Integer findIndex(STCPayVerificationOption value) {
            for (FlutterSTCPayVerificationOption e : values()) {
                if (e.value.equals(value)) return e.index;
            }
            return null;
        }
    }

    public enum FlutterTransactionType {
        sync(0, TransactionType.SYNC),
        async(1, TransactionType.ASYNC);

        private final int index;
        private final TransactionType value;

        FlutterTransactionType(final int index, final TransactionType value) {
            this.index = index;
            this.value = value;
        }

        public static Integer findIndex(TransactionType value) {
            for (FlutterTransactionType e : values()) {
                if (e.value.equals(value)) return e.index;
            }
            return null;
        }
    }

    public enum FlutterCheckoutThreeDS2Flow {
        app(0, CheckoutThreeDS2Flow.APP),
        web(1, CheckoutThreeDS2Flow.WEB),
        disabled(2, CheckoutThreeDS2Flow.DISABLED);

        private final int index;
        private final CheckoutThreeDS2Flow value;

        FlutterCheckoutThreeDS2Flow(final int index, final CheckoutThreeDS2Flow value) {
            this.index = index;
            this.value = value;
        }

        public static Integer findIndex(CheckoutThreeDS2Flow value) {
            for (FlutterCheckoutThreeDS2Flow e : values()) {
                if (e.value.equals(value)) return e.index;
            }
            return null;
        }
    }

    public enum FlutterYooKassaStatus {
        succeeded(0, YooKassaStatus.SUCCEEDED),
        pending(1, YooKassaStatus.PENDING),
        waitingForCapture(2, YooKassaStatus.WAITING_FOR_CAPTURE),
        canceled(3, YooKassaStatus.CANCELED),
        undefined(4, YooKassaStatus.UNDEFINED);

        private final int index;
        private final YooKassaStatus value;

        FlutterYooKassaStatus(final int index, final YooKassaStatus value) {
            this.index = index;
            this.value = value;
        }

        public static Integer findIndex(YooKassaStatus value) {
            for (FlutterYooKassaStatus e : values()) {
                if (e.value.equals(value)) return e.index;
            }
            return null;
        }
    }


    public enum FlutterAuthStatus {
        authenticated(0, ThreeDS2Info.AuthStatus.AUTHENTICATED),
        attemptProcessingPerformed(1, ThreeDS2Info.AuthStatus.ATTEMPT_PROCESSING_PERFORMED),
        challengeRequired(2, ThreeDS2Info.AuthStatus.CHALLENGE_REQUIRED),
        decoupledConfirmed(3, ThreeDS2Info.AuthStatus.DECOUPLED_CONFIRMED),
        denied(4, ThreeDS2Info.AuthStatus.DENIED),
        rejected(5, ThreeDS2Info.AuthStatus.REJECTED),
        failed(6, ThreeDS2Info.AuthStatus.FAILED),
        informationalOnly(7, ThreeDS2Info.AuthStatus.INFORMATIONAL_ONLY);

        private final int index;
        private final ThreeDS2Info.AuthStatus value;

        FlutterAuthStatus(final int index, final ThreeDS2Info.AuthStatus value) {
            this.index = index;
            this.value = value;
        }

        public static Integer findIndex(ThreeDS2Info.AuthStatus value) {
            for (FlutterAuthStatus e : values()) {
                if (e.value.equals(value)) return e.index;
            }
            return null;
        }
    }

}

