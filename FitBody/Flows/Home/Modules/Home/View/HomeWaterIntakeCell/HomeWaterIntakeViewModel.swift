import Resolver

struct HomeWaterIntakeViewModel: Sendable {
    var title: String {
        (waterIntakeProvider.target == nil)
            ? "Set your water intake target"
            : "Today target"
    }
    
    var waterIntakeText: String {
        guard let target = waterIntakeProvider.target else {
            return "--"
        }

        return "\(target)"
    }
    
    private let waterIntakeProvider = Resolver.resolve(WaterIntakeProvider.self)
}
