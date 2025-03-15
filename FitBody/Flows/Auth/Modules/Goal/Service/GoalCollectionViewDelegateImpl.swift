import UIKit

// MARK: - GoalCollectionViewDelegateImpl

final class GoalCollectionViewDelegateImpl: NSObject {
    typealias Goal = RegisterRequest.Goal
    
    var scrollViewDidScroll: ((UIScrollView) -> Void)?
    
    var selectedIndexPath: IndexPath?
    
    private let goals: [Goal]
    
    init(with goals: [Goal]) {
        self.goals = goals
    }
}

// MARK: - UICollectionViewDelegate

extension GoalCollectionViewDelegateImpl: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        switch cell {
        case let cell as GoalCell:
            cell.configure(
                with: GoalCellViewModel(with: goals[indexPath.item])
            )
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GoalCollectionViewDelegateImpl: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        indexPath == selectedIndexPath
            ? CGSize(width: 320, height: 540)
            : CGSize(width: 276, height: 480)
    }
}

// MARK: - UIScrollViewDelegate

extension GoalCollectionViewDelegateImpl: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollViewDidScroll?(scrollView)
    }
}
