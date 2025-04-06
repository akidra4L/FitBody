import UIKit
import SnapKit
import Kingfisher

final class WorkoutExerciseCell: UITableViewCell {
    private lazy var illustrationImageView = makeIllustrationImageView()
    private lazy var stackView = makeStackView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: WorkoutExerciseViewModel) {
        illustrationImageView.kf.setImage(with: viewModel.image)
        titleLabel.text = viewModel.title
        subtitleLabel.isHidden = viewModel.isHiddenSubtitle
        subtitleLabel.text = viewModel.subtitle
    }
    
    private func setup() {
        backgroundColor = .clear
        [illustrationImageView, stackView].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.size.equalTo(80)
        }
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(illustrationImageView.snp.trailing).offset(12)
            make.centerY.equalTo(illustrationImageView)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func makeIllustrationImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title6)
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline2)
        label.textColor = Colors.textSecondary
        return label
    }
}
