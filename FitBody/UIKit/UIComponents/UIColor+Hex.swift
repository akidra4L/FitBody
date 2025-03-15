import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        var string = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if string.hasPrefix("#") {
            string.remove(at: string.startIndex)
        }

        guard string.count == 6 else {
            assertionFailure()
            return nil
        }

        var rgbValue: UInt64 = 0
        Scanner(string: string).scanHexInt64(&rgbValue)

        self.init(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255,
            blue: Double(rgbValue & 0x0000FF) / 255,
            alpha: 1
        )
    }
}
