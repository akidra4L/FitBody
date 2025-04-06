import UIKit
import SnapKit

// MARK: - MealAddViewOutput

protocol MealAddViewOutput: FloatingPanelContentModule {
    var onClose: (() -> Void)? { get set }
    var onSuccess: ((Meal) -> Void)? { get set }
}

// MARK: - MealAddViewController

final class MealAddViewController: ClosableFloatingPanelContentViewController, MealAddViewOutput {
    var onClose: (() -> Void)?
    var onSuccess: ((Meal) -> Void)?
    
    private lazy var mainView = MealAddView(with: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func configureNavigationBar() {
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "Add meal"
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

// MARK: - MealAddViewDelegate

extension MealAddViewController: MealAddViewDelegate {
    func didTapActionButton(in view: MealAddView) {
        guard
            let kind = view.kind,
            let name = view.name
        else {
            view.configureErrorState()
            return
        }
        
        onSuccess?(
            Meal(kind: kind, title: name, date: Date())
        )
    }
}
