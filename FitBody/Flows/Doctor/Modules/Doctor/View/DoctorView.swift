import UIKit
import SnapKit

// MARK: - DoctorViewDelegate

protocol DoctorViewDelegate: AnyObject {
    func didTapActionButton(in view: DoctorView)
}

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
    private lazy var actionButton = makeActionButton()
    
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
    
    @objc
    private func actionButtonDidTap() {
        delegate?.didTapActionButton(in: self)
    }
    
    func configure(with doctor: Doctor) {
        tableHeaderView.configure(with: DoctorTableHeaderViewModel(with: doctor))
    }
    
    func changeLoadingState(to isLoading: Bool) {
        isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableView.isHidden = isLoading
        actionButton.isHidden = isLoading
    }
    
    private func setup() {
        [activityIndicatorView, tableView, actionButton].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        activityIndicatorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(actionButton.snp.top).offset(-12)
        }
        actionButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setImage(Icons.phone20x20)
        button.setTitle("Call", for: .normal)
        return button
    }
}
