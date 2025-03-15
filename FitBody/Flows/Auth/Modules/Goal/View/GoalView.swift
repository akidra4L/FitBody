import UIKit
import SnapKit

// MARK: - GoalViewDelegate

protocol GoalViewDelegate: AnyObject {
    func didTapActionButton(in view: GoalView)
}

// MARK: - GoalView

final class GoalView: UIView {
    typealias Delegate = GoalViewDelegate
    
    private(set) lazy var collectionView = GoalCollectionViewFactory().make(
        with: dataSourceImpl,
        and: delegateImpl
    )
    private lazy var actionButton = makeActionButton()
    
    private let dataSourceImpl: GoalCollectionViewDataSourceImpl
    private let delegateImpl: GoalCollectionViewDelegateImpl
    private weak var delegate: Delegate?
    
    init(
        dataSourceImpl: GoalCollectionViewDataSourceImpl,
        delegateImpl: GoalCollectionViewDelegateImpl,
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
    
    private func setup() {
        [collectionView, actionButton].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(actionButton.snp.top).offset(-24)
        }
        actionButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeActionButton() -> LoadableButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle("Confirm", for: .normal)
        return button
    }
}
