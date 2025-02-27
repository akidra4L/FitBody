import UIKit

extension UITableView {
    public func dequeueReusableCell<Cell: UITableViewCell>(
        _ type: Cell.Type = Cell.self,
        for indexPath: IndexPath
    ) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: "\(type)", for: indexPath) as? Cell else {
            fatalError("register(cellClass:) has not been implemented")
        }

        return cell
    }

    public func dequeueReusableHeaderFooterView<View: UITableViewHeaderFooterView>(
        _ type: View.Type = View.self
    ) -> View {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: "\(type)") as? View else {
            fatalError("register(aClass:) has not been implemented")
        }

        return view
    }
}
