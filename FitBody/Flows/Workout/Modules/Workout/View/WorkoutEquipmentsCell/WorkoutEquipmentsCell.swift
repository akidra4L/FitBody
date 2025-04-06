import UIKit
import SnapKit

// MARK: - WorkoutEquipmentsCell

final class WorkoutEquipmentsCell: UITableViewCell {
    var collectionViewOffset: CGFloat {
        get { getContentOffset() }
        set { collectionView.contentOffset.x = newValue }
    }
    
    private lazy var collectionView = makeCollectionView()
    
    var equipments: [Workout.Equipment] = []
    
    weak var delegate: DoctorsCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    func configure(with equipments: [Workout.Equipment]) {
        self.equipments = equipments
        
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
        collectionView.register(cellClass: WorkoutEquipmentCell.self)
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

extension WorkoutEquipmentsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        equipments.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(WorkoutEquipmentCell.self, for: indexPath)
    }
}

// MARK: - UICollectionViewDelegate

extension WorkoutEquipmentsCell: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        switch cell {
        case let cell as WorkoutEquipmentCell:
            cell.configure(with: equipments[indexPath.item])
        default:
            return
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension WorkoutEquipmentsCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        WorkoutEquipmentsCell.getSize()
    }
    
    static func getSize() -> CGSize {
        CGSize(width: 130, height: 148)
    }
}
