import Foundation

final class DietSectionsFactory {
    func make(from meals: [Meal]) -> [DietSection] {
        [
            DietSection(kind: .top, rows: [.top]),
            makeBreakfastDietSection(from: meals),
            makeLunchDietSection(from: meals),
            makeSnacksDietSection(from: meals),
            makeDinnerDietSection(from: meals)
        ].compactMap { $0 }
    }
    
    private func makeBreakfastDietSection(from meals: [Meal]) -> DietSection? {
        let sortedMeals = meals.filter { $0.kind == .breakfast }
        guard !sortedMeals.isEmpty else {
            return nil
        }
        
        return DietSection(
            kind: .meals("Breakfast", sortedMeals.count),
            rows: sortedMeals.map { .meal($0) }
        )
    }
    
    private func makeLunchDietSection(from meals: [Meal]) -> DietSection? {
        let sortedMeals = meals.filter { $0.kind == .lunch }
        guard !sortedMeals.isEmpty else {
            return nil
        }
        
        return DietSection(
            kind: .meals("Lunch", sortedMeals.count),
            rows: sortedMeals.map { .meal($0) }
        )
    }
    
    private func makeSnacksDietSection(from meals: [Meal]) -> DietSection? {
        let sortedMeals = meals.filter { $0.kind == .snacks }
        guard !sortedMeals.isEmpty else {
            return nil
        }
        
        return DietSection(
            kind: .meals("Snacks", sortedMeals.count),
            rows: sortedMeals.map { .meal($0) }
        )
    }
    
    private func makeDinnerDietSection(from meals: [Meal]) -> DietSection? {
        let sortedMeals = meals.filter { $0.kind == .dinner }
        guard !sortedMeals.isEmpty else {
            return nil
        }
        
        return DietSection(
            kind: .meals("Dinner", sortedMeals.count),
            rows: sortedMeals.map { .meal($0) }
        )
    }
}
