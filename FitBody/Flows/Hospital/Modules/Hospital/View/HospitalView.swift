import UIKit
import SnapKit

final class HospitalView: UIView {
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    private lazy var tableView = HospitalTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    
    private let dataSourceImpl: UITableViewDataSource
    private let delegateImpl: UITableViewDelegate
    
    init(
        with dataSourceImpl: UITableViewDataSource,
        and delegateImpl: UITableViewDelegate
    ) {
        self.dataSourceImpl = dataSourceImpl
        self.delegateImpl = delegateImpl
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func changeLoadingState(to isLoading: Bool) {
        isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableView.isHidden = isLoading
    }
    
    private func setup() {
        [activityIndicatorView, tableView].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
}
