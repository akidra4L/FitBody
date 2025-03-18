import Foundation
import Resolver

struct RatingViewModel: Sendable {
    typealias Rating = Double
    
    var title: String {
        ratingFormatter.string(from: rating)
    }
    
    private let ratingFormatter = Resolver.resolve(RatingFormatter.self)
    
    private let rating: Rating?
    
    init(with rating: Rating?) {
        self.rating = rating
    }
}
