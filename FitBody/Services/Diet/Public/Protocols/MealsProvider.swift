import Foundation

protocol MealsProvider: AnyObject, Sendable {
    func get() async throws -> [Meal]
}
