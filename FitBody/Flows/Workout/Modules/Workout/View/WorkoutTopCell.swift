import UIKit
import SnapKit

final class WorkoutTopCell: UITableViewCell {
    private lazy var illustrationImageView = UIImageView(image: Illustrations.workoutGraphIllustration)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(illustrationImageView)
        selectionStyle = .none
        
        illustrationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-24)
        }
    }
}
