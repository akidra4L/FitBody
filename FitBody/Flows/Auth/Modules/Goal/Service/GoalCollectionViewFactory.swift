import UIKit

final class GoalCollectionViewFactory {
    func make(
        with dataSource: UICollectionViewDataSource,
        and delegate: UICollectionViewDelegate
    ) -> UICollectionView {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.estimatedItemSize = .zero
        collectionViewLayout.minimumInteritemSpacing = 20
        collectionViewLayout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.register(cellClass: GoalCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
}
