import UIKit
import SnapKit

final class DoctorTopItemView: UIView {
    typealias ViewModel = DoctorTopItemViewModel
    
    private lazy var iconContainerView = makeIconContainerView()
    private lazy var iconImageView = makeIconImageView()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var subtitleLabel = makeSubtitleLabel()
    
    private let viewModel: ViewModel
    
    init(with viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        [iconContainerView, titleLabel, subtitleLabel].forEach { addSubview($0) }
        backgroundColor = .clear
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        iconContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(40)
        }
        iconImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconContainerView.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview()
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func makeIconContainerView() -> UIView {
        let view = UIView()
        view.addSubview(iconImageView)
        view.backgroundColor = UIColor(hex: "#F5F5FF")
        view.layer.cornerRadius = 20
        return view
    }
    
    private func makeIconImageView() -> UIImageView {
        let imageView = UIImageView(image: viewModel.icon)
        imageView.tintColor = UIColor(hex: "#BBAAF9")
        return imageView
    }
    
    private func makeTitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.body3)
        label.text = viewModel.title
        label.textAlignment = .center
        label.textColor = Colors.textPrimary
        return label
    }
    
    private func makeSubtitleLabel() -> UILabel {
        let label = UILabel(with: Fonts.headline5)
        label.text = viewModel.subtitle
        label.textAlignment = .center
        label.textColor = Colors.textSecondary
        return label
    }
}
