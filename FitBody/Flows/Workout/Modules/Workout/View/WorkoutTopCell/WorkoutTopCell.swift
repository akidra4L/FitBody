import UIKit
import SnapKit

final class WorkoutTopCell: UITableViewCell {
    private lazy var illustrationBackgroundView = makeIllustrationBackgroundView()
    private lazy var illustrationImageView = UIImageView()
    private lazy var bottomView = makeBottomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with viewModel: WorkoutTopViewModel) {
        illustrationImageView.image = viewModel.illustration
    }
    
    private func setup() {
        backgroundColor = Colors.fillPrimary
        [
            illustrationBackgroundView,
            illustrationImageView,
            bottomView
        ].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationBackgroundView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-48)
            make.size.equalTo(120)
        }
        illustrationImageView.snp.makeConstraints { make in
            make.center.equalTo(illustrationBackgroundView)
        }
        bottomView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    private func makeIllustrationBackgroundView() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.fillBackgroundSecondary
        view.layer.cornerRadius = 60
        return view
    }
    
    private func makeBottomView() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.fillBackgroundPrimary
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }
}
