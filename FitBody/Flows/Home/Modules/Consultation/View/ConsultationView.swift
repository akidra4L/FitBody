import UIKit
import SnapKit

final class ConsultationView: UIView {
    typealias Delegate = ConsultationBottomView.Delegate
    
    private lazy var scrollView = makeScrollView()
    private lazy var responseLabel = makeResponseLabel()
    private lazy var emptyTitleLabel = makeEmptyTitleLabel()
    private(set) lazy var bottomView = ConsultationBottomView(with: delegate)
    
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
    
    func updateResponse(_ text: String?, animated: Bool) {
        responseLabel.text = text
        let hasResponse = (text != nil && !text!.isEmpty)
        let duration = animated ? 0.4 : 0.0
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseInOut],
            animations: { [weak self] in
                guard let self else {
                    return
                }

                scrollView.alpha = hasResponse ? 1.0 : 0.0
                emptyTitleLabel.alpha = hasResponse ? 0.0 : 1.0
                layoutIfNeeded()
            },
            completion: { [weak self] _ in
                guard let self else {
                    return
                }
                
                scrollView.isHidden = !hasResponse
                emptyTitleLabel.isHidden = hasResponse
                
                if hasResponse {
                    let point = CGPoint(x: 0, y: -scrollView.adjustedContentInset.top)
                    scrollView.setContentOffset(point, animated: false)
                }
            }
        )
    }
    
    @objc
    private func applicationStateDidChange(with notification: Notification) {
        let appearance = KeyboardAppearance(from: notification)
        let bottomOffset = (notification.name == UIResponder.keyboardWillShowNotification)
            ? -(appearance.endFrame.height - safeAreaInsets.bottom)
            : 0

        UIView.animate(
            withDuration: appearance.animationDuration,
            delay: 0,
            options: appearance.animationOptions,
            animations: { [weak self] in
                guard let self else {
                    return
                }

                bottomView.snp.updateConstraints { update in
                    update.bottom.equalTo(self.safeAreaLayoutGuide).offset(bottomOffset)
                }
                layoutIfNeeded()
            },
            completion: nil
        )
    }
    
    private func setup() {
        [scrollView, emptyTitleLabel, bottomView].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary

        setupConstraints()
        setupObservers()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(bottomView.snp.top).offset(-16)
        }
        responseLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
            make.width.equalToSuperview()
        }
        emptyTitleLabel.snp.makeConstraints { make in
            make.center.equalTo(scrollView)
            make.directionalHorizontalEdges.equalToSuperview().inset(32)
        }
        bottomView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
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
        scrollView.addSubview(responseLabel)
        scrollView.alwaysBounceVertical = true
        scrollView.isHidden = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }
    
    private func makeResponseLabel() -> UILabel {
        let label = UILabel(with: Fonts.body2)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = Colors.textPrimary
        label.lineBreakMode = .byWordWrapping
        return label
    }
    
    private func makeEmptyTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body1)
        label.text = "Write your first message"
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
}
