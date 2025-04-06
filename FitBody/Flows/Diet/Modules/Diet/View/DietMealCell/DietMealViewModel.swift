import Resolver

struct DietMealViewModel: Sendable {
    var title: String {
        meal.title
    }
    
    var subtitle: String {
        dateFormatter.string(from: meal.date, withFormat: "hh:mm a")
    }
    
    private let dateFormatter = Resolver.resolve(PropertyDateFormatter.self)
    
    private let meal: Meal
    
    init(with meal: Meal) {
        self.meal = meal
    }
}
