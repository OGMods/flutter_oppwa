import Foundation

class FlutterProviderUtils {
    static func convertTransactionToMap(transaction: OPPTransaction) -> Dictionary<String,Any>{
        var map:Dictionary<String,Any> = Dictionary()
        map["transactionType"] = transactionTypeToIndex(value: transaction.type)
        map["brandSpecificInfo"] = transaction.brandSpecificInfo
        // map["paymentParams"] = 
        return map
    }
    static func indexToProviderMode(index: Int) -> OPPProviderMode? {
        switch index {
        case 0:
            return OPPProviderMode.test
        case 1:
            return OPPProviderMode.live
        default:
            return nil
        }
    }
    static func indexToSTCPayVerificationOption(index: Int) -> OPPSTCPayVerificationOption? {
        switch index {
        case 0:
            return OPPSTCPayVerificationOption.phone
        case 1:
            return OPPSTCPayVerificationOption.qrCode
        default:
            return nil
        }
    }
    static func transactionTypeToIndex(value: OPPTransactionType) -> Int? {
        switch value {
        case OPPTransactionType.synchronous:
            return 0
        case OPPTransactionType.asynchronous:
            return 1
        default:
            return nil
        }
    }
    static func checkoutThreeDS2FlowToIndex(value: OPPThreeDS2Flow) -> Int? {
        
        switch value {
        case OPPThreeDS2Flow.app:
            return 0
        case OPPThreeDS2Flow.web:
            return 1
        case OPPThreeDS2Flow.disabled:
            return 2
        default:
            return nil
        }
    }
    static func yooKassaStatusToIndex(value: OPPYooKassaStatus) -> Int? {
        switch value {
        case OPPYooKassaStatus.succeeded:
            return 0
        case OPPYooKassaStatus.pending:
            return 1
        case OPPYooKassaStatus.waitingForCapture:
            return 2
        case OPPYooKassaStatus.canceled:
            return 3
        case OPPYooKassaStatus.undefined:
            return 4
        default:
            return nil
        }
    }
    static func authStatusToIndex(value: OPPThreeDS2Status) -> Int? {
        switch value {
        case OPPThreeDS2Status.authenticated:
            return 0
        case OPPThreeDS2Status.attemptProcessingPerformed:
            return 1
        case OPPThreeDS2Status.challengeRequired:
            return 2
        case OPPThreeDS2Status.decoupledConfirmed:
            return 3
        case OPPThreeDS2Status.denied:
            return 4
        case OPPThreeDS2Status.rejected:
            return 5
        case OPPThreeDS2Status.failed:
            return 6
        case OPPThreeDS2Status.informationalOnly:
            return 7
        default:
            return nil
        }
    }
}
