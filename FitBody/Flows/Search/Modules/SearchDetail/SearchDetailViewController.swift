import UIKit
import SnapKit

// MARK: - SearchDetailViewOutput

protocol SearchDetailViewOutput: FloatingPanelContentModule {
    var onClose: (() -> Void)? { get set }
    var onSuccess: (() -> Void)? { get set }
}

// MARK: - SearchDetailViewController

final class SearchDetailViewController: ClosableFloatingPanelContentViewController, SearchDetailViewOutput {
    var onClose: (() -> Void)?
    var onSuccess: (() -> Void)?
    
    private lazy var mainView = SearchDetailView(with: hospitalMapItem, and: self)
    
    private let hospitalMapItem: HospitalMapItem
    
    init(with hospitalMapItem: HospitalMapItem) {
        self.hospitalMapItem = hospitalMapItem
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func configureNavigationBar() {
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
    }
    
    override func closeBarButtonItemDidTap() {
        onClose?()
    }
    
    private func setup() {
        view.addSubview(mainView)

        setupConstraints()
    }

    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - SearchDetailViewDelegate

extension SearchDetailViewController: SearchDetailViewDelegate {
    func didTapActionButton(in view: SearchDetailView) {
        onSuccess?()
    }
}
