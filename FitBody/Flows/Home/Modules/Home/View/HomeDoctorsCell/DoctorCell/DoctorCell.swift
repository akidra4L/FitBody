import UIKit
import SnapKit
import Kingfisher

final class DoctorCell: UICollectionViewCell {
    private lazy var imageView = makeImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var ratingView = RatingView()
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.25) { [weak self] in
                guard let self else {
                    return
                }

                imageView.transform = isHighlighted ? .init(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: DoctorCellViewModel) {
        imageView.kf.setImage(with: viewModel.illustration)
        titleLabel.text = viewModel.title
        ratingView.configure(with: viewModel.ratingViewModel)
    }
    
    private func setup() {
        [imageView, titleLabel, ratingView].forEach { contentView.addSubview($0) }
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(160)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        ratingView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeImageView() -> UIImageView {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        return view
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.title3)
        label.textColor = Colors.textPrimary
        return label
    }
}
