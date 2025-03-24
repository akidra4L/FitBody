import UIKit
import SnapKit

final class DoctorTopCell: UITableViewCell {
    private lazy var stackView = makeStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with doctor: Doctor) {
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        DoctorTopItemViewModel.Kind.allCases.forEach { kind in
            stackView.addArrangedSubview(
                DoctorTopItemView(
                    with: DoctorTopItemViewModel(with: doctor, and: kind)
                )
            )
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
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview().offset(-24)
        }
    }
    
    private func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.spacing = 40
        return stackView
    }
}
