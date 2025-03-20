import UIKit
import SnapKit

final class DoctorReviewCell: UITableViewCell {
    private lazy var reviewView = ReviewView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with review: String) {
        reviewView.configure(with: review)
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(reviewView)
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        reviewView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 0, left: 16, bottom: 12, right: 16)
            )
        }
    }
}
