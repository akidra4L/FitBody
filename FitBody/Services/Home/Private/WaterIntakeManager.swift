import Foundation

// MARK: - WaterIntakeManager

final class WaterIntakeManager {
    private let _target = UserDefaultsWrapper<Int>(key: "waterIntakeTarget")
}

// MARK: - WaterIntakeProvider

extension WaterIntakeManager: WaterIntakeProvider {
    var target: Int? {
        _target.value
    }
}

// MARK: - WaterIntakeSetter

extension WaterIntakeManager: WaterIntakeSetter {
    func set(with target: Int) {
        _target.update(with: target)
    }
}
