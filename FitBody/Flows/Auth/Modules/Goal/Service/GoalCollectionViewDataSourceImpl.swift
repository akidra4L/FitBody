import UIKit

// MARK: - GoalCollectionViewDataSourceImpl

final class GoalCollectionViewDataSourceImpl: NSObject {
    typealias Goal = RegisterRequest.Goal
    
    private let goals: [Goal]
    
    init(with goals: [Goal]) {
        self.goals = goals
    }
}

// MARK: - UICollectionViewDataSource

extension GoalCollectionViewDataSourceImpl: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        goals.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(GoalCell.self, for: indexPath)
    }
}
