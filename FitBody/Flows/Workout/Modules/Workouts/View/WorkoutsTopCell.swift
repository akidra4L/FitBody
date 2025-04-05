import UIKit
import SnapKit

final class WorkoutsTopCell: UITableViewCell {
    private lazy var illustrationImageView = UIImageView(image: Illustrations.workoutGraphIllustration)
    private lazy var bottomView = makeBottomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        backgroundColor = Colors.fillPrimary
        [illustrationImageView, bottomView].forEach { contentView.addSubview($0) }
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        illustrationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-48)
        }
        bottomView.snp.makeConstraints { make in
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    private func makeBottomView() -> UIView {
        let view = UIView()
        view.backgroundColor = Colors.fillBackgroundPrimary
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }
}
