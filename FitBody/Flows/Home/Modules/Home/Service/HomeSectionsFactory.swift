import Foundation

final class HomeSectionsFactory {
    func make() -> [HomeSection] {
        [
            HomeSection(kind: .bookDoctor, rows: [.bookDoctor]),
            HomeSection(kind: .waterIntake, rows: [.waterIntake])
        ]
    }
}
