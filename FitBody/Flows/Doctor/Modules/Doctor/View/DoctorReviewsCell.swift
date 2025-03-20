import UIKit
import SnapKit

final class DoctorReviewsCell: UITableViewCell {
    private lazy var stackView = makeStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with reviews: [String]) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        reviews.forEach { review in
            let view = ReviewView()
            view.configure(with: review)
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(stackView)
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview().inset(
                UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
            )
        }
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }
}
