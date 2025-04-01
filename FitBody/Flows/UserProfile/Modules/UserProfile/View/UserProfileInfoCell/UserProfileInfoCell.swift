import UIKit
import SnapKit
import Kingfisher

// MARK: - UserProfileInfoCell

final class UserProfileInfoCell: UITableViewCell {
    private lazy var avatarImageView = UIImageView(image: Illustrations.profileAvatarEmptyIllustration)
    private lazy var nameLabel = makeNameLabel()
    private lazy var birthDateLabel = makeBirthDateLabel()
    private lazy var horizontalStackView = makeHorizontalStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: UserProfileInfoViewModel) {
        nameLabel.text = viewModel.name
        birthDateLabel.text = viewModel.birthDateText
        horizontalStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        viewModel.info.forEach {
            horizontalStackView.addArrangedSubview(
                InfoView(with: $0.title, and: $0.subtitle)
            )
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        [
            avatarImageView,
            nameLabel,
            birthDateLabel,
            horizontalStackView
        ].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(64)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        birthDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    private func makeNameLabel() -> UILabel {
        let label = UILabel(with: Fonts.title2)
        label.numberOfLines = 2
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeBirthDateLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.textColor = Colors.textSecondary
        return label
    }
    
    private func makeHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.distribution = .fillEqually
        return stackView
    }
}

// MARK: - UserProfileInfoCell.InfoView

extension UserProfileInfoCell {
    private final class InfoView: UIView {
        private lazy var titleLabel = makeTitleLabel()
        private lazy var subtitleLabel = makeSubtitleLabel()
        
        private let title: String
        private let subtitle: String
        
        init(with title: String, and subtitle: String) {
            self.title = title
            self.subtitle = subtitle
            super.init(frame: .zero)
            
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) {
            nil
        }
        
        private func setup() {
            [titleLabel, subtitleLabel].forEach { addSubview($0) }
            backgroundColor = Colors.fillBackgroundSecondary
            layer.cornerRadius = 12
            
            setupConstraints()
        }
        
        private func setupConstraints() {
            titleLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(8)
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
            }
            subtitleLabel.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.directionalHorizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().offset(-8)
            }
        }
        
        private func makeTitleLabel() -> UILabel {
            let label = UILabel(with: Fonts.headline1)
            label.text = title
            label.textAlignment = .center
            label.textColor = UIColor(hex: "#92A3FD")!
            return label
        }
        
        private func makeSubtitleLabel() -> UILabel {
            let label = UILabel(with: Fonts.headline5)
            label.text = subtitle
            label.textAlignment = .center
            label.textColor = Colors.textSecondary
            return label
        }
    }
}
