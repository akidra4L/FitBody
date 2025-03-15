import UIKit

/// A utility struct to encapsulate information about the keyboard appearance from a given notification.
///
/// `KeyboardAppearance` provides properties to access various attributes of the keyboard appearance, such as frame, animation details, and whether it belongs to the current app.
///
///
/// Usage Example:
/// ```swift
/// let keyboardInfo = KeyboardAppearance(from: notification)
/// let animationDuration = keyboardInfo.animationDuration
/// let animationCurve = keyboardInfo.animationCurve
/// ```
@MainActor
public struct KeyboardAppearance {
    private typealias UserInfo = [AnyHashable: Any]

    public var beginFrame: CGRect {
        (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    }

    public var endFrame: CGRect {
        (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
    }

    public var belongsToCurrentApp: Bool {
        (userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool) ?? true
    }

    public var animationDuration: TimeInterval {
        (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
    }

    public var animationCurve: UIView.AnimationCurve {
        guard let value = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? Int else {
            return .easeInOut
        }

        return UIView.AnimationCurve(rawValue: value) ?? .easeInOut
    }

    public var animationOptions: UIView.AnimationOptions {
        UIView.AnimationOptions(
            rawValue: UInt(animationCurve.rawValue << 16)
        )
    }

    private let userInfo: UserInfo

    public init(from notification: Notification) {
        self.userInfo = notification.userInfo ?? [:]
    }
}
