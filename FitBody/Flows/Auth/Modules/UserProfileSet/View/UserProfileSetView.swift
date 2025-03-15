import UIKit
import SnapKit

// MARK: - UserProfileSetViewDelegate

protocol UserProfileSetViewDelegate: AnyObject {
    func didTapActionButton(in view: UserProfileSetView)
}

// MARK: - UserProfileSetView

final class UserProfileSetView: UIView {
    typealias Delegate = UserProfileSetViewDelegate
    
    var selectedGender: Gender? {
        contentView.selectedGender
    }
    
    var selectedBirthDate: Date {
        contentView.selectedBirthDate
    }
    
    var weight: Double? {
        contentView.weight
    }
    
    var height: Double? {
        contentView.height
    }
    
    private lazy var scrollView = makeScrollView()
    private lazy var contentView = UserProfileSetContentView()
    private lazy var actionButton = makeActionButton()
    
    private let notificationCenter = NotificationCenter.default
    
    private weak var delegate: Delegate?
    
    init(with delegate: Delegate?) {
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
    
    @objc
    private func applicationStateDidChange(with notification: Notification) {
        let appearance = KeyboardAppearance(from: notification)
        let bottomOffset = (notification.name == UIResponder.keyboardWillShowNotification)
            ? -(appearance.endFrame.height - safeAreaInsets.bottom + 12)
            : -12

        UIView.animate(
            withDuration: appearance.animationDuration,
            delay: 0,
            options: appearance.animationOptions,
            animations: { [weak self] in
                guard let self else {
                    return
                }

                actionButton.snp.updateConstraints { make in
                    make.bottom.equalTo(self.safeAreaLayoutGuide).offset(bottomOffset)
                }
                layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    func configureErrorVisibility() {
        contentView.configureErrorVisibility()
    }
    
    private func setup() {
        [scrollView, actionButton].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
        setupObservers()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func setupObservers() {
        notificationCenter.addObserver(
            self,
            selector: #selector(applicationStateDidChange),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        notificationCenter.addObserver(
            self,
            selector: #selector(applicationStateDidChange),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func makeScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.addSubview(contentView)
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        return button
    }
}
