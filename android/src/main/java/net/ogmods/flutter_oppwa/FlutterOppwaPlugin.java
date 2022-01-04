package net.ogmods.flutter_oppwa;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.oppwa.mobile.connect.exception.PaymentException;
import com.oppwa.mobile.connect.payment.card.CardPaymentParams;
import com.oppwa.mobile.connect.provider.Connect;
import com.oppwa.mobile.connect.provider.Transaction;

import androidx.browser.customtabs.CustomTabsClient;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterOppwaPlugin
 */
public class FlutterOppwaPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private ActivityPluginBinding binding;
    private Connect.ProviderMode mode;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_oppwa");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (binding == null) {
            result.error("no_activity", "flutter_oppwa plugin requires a foreground activity.", null);
            return;
        }
        try {
            switch (call.method) {
                case "initialize":
                    int mode = getArgument(call, "mode");
                    this.mode = FlutterOppwaUtils.FlutterProviderMode.fromIndex(mode);
                    if (this.mode == null) {
                        throwInvalid("mode", Integer.toString(mode));
                    }
                   boolean didInitialize = CustomTabsClient.connectAndInitialize(binding.getActivity(), FlutterOppwaUtils.getPackageName(binding.getActivity()));
                    result.success(didInitialize);
                    break;
                case "card_transaction":
                    checkInitialized();
                    handleCardTransaction(call, result);
                    break;
                case "checkout_info_request":
                    checkInitialized();
                    handleCheckoutInfoRequest(call, result);
                    break;
                default:
                    throw new FlutterOppwaException("invalid_methods", "there is no method with the name " + call.method, null);
            }
        } catch (FlutterOppwaException e) {
            result.error(e.getErrorCode(), e.getMessage(), null);
        } catch (PaymentException e) {
            result.error("payment_error", e.getMessage(), FlutterOppwaUtils.convertPaymentExceptionToMap(e));
        } catch (Exception e) {
            result.error("unhandled_exception", e.getMessage(), null);
        }
    }

    public void handleCardTransaction(@NonNull MethodCall call, @NonNull Result result) throws Exception {
        FlutterOppwaDelegate delegate = new FlutterOppwaDelegate(binding, this.mode, result);
        String checkoutId = getArgument(call, "checkoutId");
        String number = getArgument(call, "number");
        String brand = getNullableArgument(call, "brand");
        String holder = getNullableArgument(call, "holder");
        String expiryMonth = getNullableArgument(call, "expiryMonth");
        String expiryYear = getNullableArgument(call, "expiryYear");
        String cvv = getNullableArgument(call, "cvv");
        Boolean tokenize = getNullableArgument(call, "tokenize");
        CardPaymentParams paymentParams;

        if (brand == null) {
            paymentParams = new CardPaymentParams(checkoutId, number, holder, expiryMonth, expiryYear, cvv);
        } else {
            paymentParams = new CardPaymentParams(checkoutId, brand, number, holder, expiryMonth, expiryYear, cvv);
        }
        if (tokenize != null) {
            paymentParams.setTokenizationEnabled(tokenize);
        }
        Transaction transaction = new Transaction(paymentParams);
        delegate.submitTransaction(transaction);
    }

    public void handleCheckoutInfoRequest(@NonNull MethodCall call, @NonNull Result result) throws Exception {
        FlutterOppwaDelegate delegate = new FlutterOppwaDelegate(binding, this.mode, result);
        String checkoutId = getArgument(call, "checkoutId");
        delegate.requestCheckoutInfo(checkoutId);
    }
    public void checkInitialized() throws FlutterOppwaException {
        if (this.mode == null) {
            throw new FlutterOppwaException("not_initialized", "the plugin has not been initialized yet, please call initialize first", null);
        }
    }

    public void throwInvalid(String name, String value) throws FlutterOppwaException {
        throw new FlutterOppwaException("invalid_arguments", "there is no " + name + " with the value of " + value, null);
    }

    @NonNull
    public <T> T getArgument(@NonNull MethodCall call, String name) throws FlutterOppwaException {
        return getArgument(call, name, false);
    }

    @Nullable
    public <T> T getNullableArgument(@NonNull MethodCall call, String name) throws FlutterOppwaException {
        return getArgument(call, name, true);
    }

    public <T> T getArgument(@NonNull MethodCall call, String name, boolean nullable) throws FlutterOppwaException {
        if (!call.hasArgument(name)) {
            if (nullable) {
                return null;
            } else {
                throw new FlutterOppwaException("invalid_arguments", name + " argument is required", null);
            }
        }
        T value = call.argument(name);
        if (!nullable && value == null) {
            throw new FlutterOppwaException("invalid_arguments", name + " should not be null", null);
        }
        return value;
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        this.binding = binding;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        this.binding = binding;
    }

    @Override
    public void onDetachedFromActivity() {
        binding = null;
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
    }


}
