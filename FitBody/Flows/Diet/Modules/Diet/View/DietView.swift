import UIKit
import SnapKit

// MARK: - DietViewDelegate

protocol DietViewDelegate: AnyObject {
    func didTapActionButton(in view: DietView)
}

// MARK: - DietView

final class DietView: UIView {
    typealias Delegate = DietViewDelegate
    
    private lazy var activityIndicatorView = ActivityIndicatorView(size: .large, color: Colors.fillPrimary)
    private lazy var tableView = DietTableViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    private lazy var actionButton = makeActionButton()
    
    private let dataSourceImpl: DietTableViewDataSourceImpl
    private let delegateImpl: DietTableViewDelegateImpl
    private weak var delegate: Delegate?
    
    init(
        dataSourceImpl: DietTableViewDataSourceImpl,
        delegateImpl: DietTableViewDelegateImpl,
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
    
    func changeLoadingState(to isLoading: Bool) {
        isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        tableView.isHidden = isLoading
        actionButton.isHidden = isLoading
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    private func setup() {
        [
            activityIndicatorView,
            tableView,
            actionButton
        ].forEach { addSubview($0) }
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
        actionButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-48)
            make.size.equalTo(60)
        }
    }
    
    private func makeActionButton() -> UIControl {
        let button = DietActionButton()
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        return button
    }
}
