import Foundation

extension Date {
    static func makeUsingDateComponents(
        year: Int? = nil,
        minute: Int? = nil
    ) -> Date? {
        let dateComponents = DateComponents(
            calendar: Calendar(identifier: .gregorian),
            timeZone: .utc,
            year: year,
            minute: minute
        )

        guard let date = dateComponents.date else {
            assertionFailure()
            return nil
        }

        return date
    }
}
