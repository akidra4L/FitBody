import UIKit

extension UICollectionView {
    func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ type: Cell.Type = Cell.self,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(type)", for: indexPath) as? Cell else {
            fatalError("register(cellClass:) has not been implemented")
        }

        return cell
    }

    func dequeueReusableSupplementaryView<View: UICollectionReusableView>(
        _ type: View.Type = View.self,
        ofKind elementKind: String,
        for indexPath: IndexPath
    ) -> View {
        guard
            let view = dequeueReusableSupplementaryView(
                ofKind: elementKind,
                withReuseIdentifier: "\(type)",
                for: indexPath
            ) as? View
        else {
            fatalError("register(aClass:) has not been implemented")
        }

        return view
    }
}
