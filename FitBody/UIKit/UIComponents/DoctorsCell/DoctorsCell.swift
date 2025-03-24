import UIKit
import SnapKit

// MARK: DoctorsCellDelegate

protocol DoctorsCellDelegate: AnyObject {
    func doctorsCell(_ cell: DoctorsCell, didSelectDoctor doctor: HomeDoctorListItem)
}

// MARK: - DoctorsCell

final class DoctorsCell: UITableViewCell {
    var collectionViewOffset: CGFloat {
        get { getContentOffset() }
        set { collectionView.contentOffset.x = newValue }
    }
    
    private lazy var collectionView = makeCollectionView()
    
    var doctors: [HomeDoctorListItem] = []
    
    weak var delegate: DoctorsCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with doctors: [HomeDoctorListItem]) {
        self.doctors = doctors
        
        collectionView.reloadData()
    }
    
    private func setup() {
        backgroundColor = .clear
        contentView.addSubview(collectionView)
        contentView.clipsToBounds = true
        selectionStyle = .none
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.directionalEdges.equalTo(
                UIEdgeInsets(top: 8, left: 0, bottom: 24, right: 0)
            )
        }
    }
    
    private func makeCollectionView() -> UICollectionView {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 12
        collectionViewLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(cellClass: DoctorCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }
    
    private func getContentOffset() -> CGFloat {
        let contentOffset = collectionView.contentOffset.x
        let minOffset: CGFloat = -16
        let maxOffset: CGFloat = collectionView.contentSize.width - collectionView.frame.width + 16

        return max(minOffset, min(contentOffset, maxOffset))
    }
}

// MARK: - UICollectionViewDataSource

extension DoctorsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        doctors.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(DoctorCell.self, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate

extension DoctorsCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        guard let doctor = doctors[safe: indexPath.item] else {
            assertionFailure()
            return
        }
        
        delegate?.doctorsCell(self, didSelectDoctor: doctor)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        switch cell {
        case let cell as DoctorCell:
            cell.configure(
                with: DoctorCellViewModel(with: doctors[indexPath.item])
            )
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension DoctorsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        DoctorsCell.getSize()
    }
    
    static func getSize() -> CGSize {
        CGSize(
            width: 250,
            height: DoctorsCell.getHeight()
        )
    }

    static func getHeight() -> CGFloat {
        // imageViewHeight - 160
        // titleHeight - 44
        // ratingHeight - 16
        // addressHeight - 24
        160 + 44 + 16 + 24
    }
}
