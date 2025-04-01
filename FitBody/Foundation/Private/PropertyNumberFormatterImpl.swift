import Foundation

final class PropertyNumberFormatterImpl: PropertyNumberFormatter {
    func string(from double: Double, maximumFractionDigits: Int) -> String? {
        let formatter = formatter(maximumFractionDigits: maximumFractionDigits)
        let number = NSNumber(value: double)
        guard let string = formatter.string(from: number) else {
            assertionFailure()
            return nil
        }
        
        return string
    }
    
    private func formatter(maximumFractionDigits: Int) -> NumberFormatter {
        let formatter = NumberFormatter()
        
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.roundingMode = .up
        
        return formatter
    }
}
