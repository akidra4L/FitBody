import Foundation

final class PropertyNumberFormatterImpl: PropertyNumberFormatter {
    func string(from double: Double) -> String? {
        let formatter = formatter()
        let number = NSNumber(value: double)
        guard let string = formatter.string(from: number) else {
            assertionFailure()
            return nil
        }
        
        return string
    }
    
    private func formatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 1
        formatter.roundingMode = .up
        
        return formatter
    }
}
