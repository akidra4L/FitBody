import UIKit
import SnapKit

// MARK: - DoctorViewDelegate

protocol DoctorViewDelegate: AnyObject {}

// MARK: - DoctorView

final class DoctorView: UIView {
    typealias Delegate = DoctorViewDelegate
    
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    private lazy var tableHeaderView = DoctorTableHeaderView()
    private(set) lazy var tableView = DoctorTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl,
        tableHeaderView: tableHeaderView
    )
    
    private let dataSourceImpl: DoctorTableViewDataSourceImpl
    private let delegateImpl: DoctorTableViewDelegateImpl
    private weak var delegate: Delegate?
    
    init(
        dataSourceImpl: DoctorTableViewDataSourceImpl,
        delegateImpl: DoctorTableViewDelegateImpl,
        delegate: Delegate?
    ) {
        self.dataSourceImpl = dataSourceImpl
        self.delegateImpl = delegateImpl
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with doctor: Doctor) {
        tableHeaderView.configure(with: DoctorTableHeaderViewModel(with: doctor))
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
            make.top.equalTo(safeAreaLayoutGuide).offset(12)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
