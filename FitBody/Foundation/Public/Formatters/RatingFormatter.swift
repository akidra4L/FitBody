import Foundation

protocol RatingFormatter: AnyObject, Sendable {
    typealias Rating = Double
    
    func string(from rating: Rating?) -> String
}
