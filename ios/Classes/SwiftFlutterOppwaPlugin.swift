import Flutter
import UIKit

public class SwiftFlutterOppwaPlugin: NSObject, FlutterPlugin {
    var oppMode: OPPProviderMode?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_oppwa", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterOppwaPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        do{
            switch call.method {
            case "initialize":
                let mode: Int? = try getArgument(call, "mode", true)
                oppMode = FlutterProviderUtils.indexToProviderMode(index: mode!)
                if oppMode == nil {
                    try throwInvalid("mode", mode!)
                }
                result(true)
            case "card_transaction":
                result(FlutterError.init(code: "BAD_ARGS",
                                         message: "Wrong argument - connect expects the name as an argument)" ,
                                         details: nil))
            case "checkout_info_request":
                result(FlutterError.init(code: "BAD_ARGS",
                                         message: "Wrong argument - connect expects the name as an argument)" ,
                                         details: nil))
            default:
                throw SwiftFlutterOppwaException.init(errorCode: "invalid_method", message: "there is no method with the name " + call.method)
            }
            
        } catch(let error) {
            if let e = error as? SwiftFlutterOppwaException {
                result(FlutterError.init(code: e.errorCode,
                                         message: e.message,
                                         details: nil))
            }else {
                result(FlutterError.init(code: "unhandled_exception",
                                         message: error.localizedDescription,
                                         details: nil))
            }
            
        }
    }
    func getArgument<T>(_ call: FlutterMethodCall, _ name: String, _ required: Bool) throws -> T?  {
        let args = call.arguments as? Dictionary<String, Any>
        if args == nil {
            throw SwiftFlutterOppwaException.init(errorCode: "invalid_arguments", message: "expected arguments but found null")
        }
        let contain = args!.keys.contains(name)
        if contain {
            let result = args![name] as? T
            if(result == nil && required){
                throw SwiftFlutterOppwaException.init(errorCode: "invalid_arguments", message: name + " can not be null")
            }
            return result
        } else if required {
            throw SwiftFlutterOppwaException.init(errorCode: "invalid_arguments", message: " argument with the name of '\(name)' is required")
        }
        return nil
    }
    func throwInvalid( _ name: String,  _ value: Any) throws {
        throw SwiftFlutterOppwaException.init(errorCode: "invalid_arguments", message: "there is no \(name) with the value of \(value)")
    }
}
