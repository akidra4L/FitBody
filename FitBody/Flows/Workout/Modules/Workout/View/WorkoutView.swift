import UIKit
import SnapKit

final class WorkoutView: UIView {
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    private lazy var tableView = WorkoutTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    
    private let dataSourceImpl: WorkoutTableViewDataSourceImpl
    private let delegateImpl: WorkoutTableViewDelegateImpl
    
    init(
        with dataSourceImpl: WorkoutTableViewDataSourceImpl,
        and delegateImpl: WorkoutTableViewDelegateImpl
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
    
    func changeLoadingState(to isLoading: Bool) {
        isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableView.isHidden = isLoading
    }
    
    func reloadData() {
        tableView.reloadData()
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
