import UIKit
import SnapKit
import Kingfisher

final class HomeBookDoctorCell: UITableViewCell {
    private lazy var containerView = makeContainerView()
    private lazy var illustrationImageView = UIImageView(image: Illustrations.homeBookDoctorIllustration)
    private lazy var titleLabel = makeTitleLabel()
    private lazy var actionButton = makeActionButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)

        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.containerView.transform = highlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
            )
        }
        illustrationImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.size.equalTo(
                CGSize(width: 116, height: 76)
            )
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(illustrationImageView.snp.leading).offset(-16)
        }
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func makeContainerView() -> UIView {
        let view = UIView()
        [
            illustrationImageView,
            titleLabel,
            actionButton
        ].forEach { view.addSubview($0) }
        view.backgroundColor = Colors.fillPrimary.withAlphaComponent(0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title4)
        label.numberOfLines = 2
        label.text = "Book your visit to Doctor"
        label.textColor = Colors.fillInput
        return label
    }
    
    private func makeActionButton() -> UIButton {
        let button = PrimaryButton(size: .small)
        button.setTitle("Learn More", for: .normal)
        return button
    }
}
