import UIKit
import SnapKit

// MARK: - SearchDetailViewDelegate

protocol SearchDetailViewDelegate: AnyObject {
    func didTapActionButton(in view: SearchDetailView)
}

// MARK: - SearchDetailView

final class SearchDetailView: UIView {
    typealias Delegate = SearchDetailViewDelegate
    
    private lazy var titleLabel = makeTitleLabel()
    private lazy var descriptionLabel = makeDescriptionLabel()
    private lazy var addressView = makeAddressView()
    private lazy var ratingView = makeRatingView()
    private lazy var actionButton = makeActionButton()
    
    private let hospitalMapItem: HospitalMapItem
    private weak var delegate: Delegate?
    
    init(with hospitalMapItem: HospitalMapItem, and delegate: Delegate?) {
        self.hospitalMapItem = hospitalMapItem
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
        [
            ratingView,
            titleLabel,
            descriptionLabel,
            addressView,
            actionButton
        ].forEach { addSubview($0) }
        backgroundColor = Colors.fillBackgroundPrimary
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        ratingView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalToSuperview().offset(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(ratingView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
        }
        addressView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(actionButton.snp.top).offset(-32)
        }
        actionButton.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-12)
        }
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.text = hospitalMapItem.name
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeDescriptionLabel() -> UILabel {
        let label = UILabel(with: Fonts.body2)
        label.numberOfLines = 0
        label.text = hospitalMapItem.description
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeAddressView() -> UIView {
        let view = AddressView()
        view.configure(with: hospitalMapItem.address.name)
        return view
    }
    
    private func makeRatingView() -> UIView {
        let view = RatingView()
        view.configure(
            with: RatingViewModel(with: hospitalMapItem.rating.score)
        )
        return view
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .largeFixed)
        button.addTarget(self, action: #selector(actionButtonDidTap), for: .touchUpInside)
        button.setTitle("Go to Hospital", for: .normal)
        return button
    }
}
