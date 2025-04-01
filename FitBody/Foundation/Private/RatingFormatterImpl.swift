import Resolver

final class RatingFormatterImpl: RatingFormatter {
    private let propertyNumberFormatter = Resolver.resolve(PropertyNumberFormatter.self)

    func string(from rating: Rating?) -> String {
        guard
            let rating,
            rating > 0
        else {
            return "--"
        }

        guard let formattedRating = propertyNumberFormatter.string(from: rating, maximumFractionDigits: 1) else {
            assertionFailure()
            return "--"
        }

        return formattedRating
    }
}
