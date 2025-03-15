import UIKit
import Resolver

// MARK: - GoalViewOutput

protocol GoalViewOutput: AnyObject {
    var onFinish: (() -> Void)? { get set }
}

// MARK: - GoalViewController

final class GoalViewController: BaseViewController, GoalViewOutput {
    typealias Goal = RegisterRequest.Goal
    
    var onFinish: (() -> Void)?
    
    var goals: [Goal] {
        Goal.allCases
    }
    
    private var selectedGoal: Goal = .improveMobility
    private var selectedIndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            guard oldValue != selectedIndexPath else {
                return
            }
            
            selectedGoal = goals[selectedIndexPath.item]
            delegateImpl.selectedIndexPath = selectedIndexPath
            mainView.collectionView.performBatchUpdates(nil)
        }
    }
    
    private lazy var mainView = GoalView(
        dataSourceImpl: dataSourceImpl,
        delegateImpl: delegateImpl,
        delegate: self
    )
    
    private lazy var dataSourceImpl = GoalCollectionViewDataSourceImpl(with: goals)
    private lazy var delegateImpl = GoalCollectionViewDelegateImpl(with: goals)
    
    @Injected private var authManager: AuthManager
    @Injected private var authRegisterProvider: AuthRegisterProvider
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegateImpl()
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.title = "What is your goal?"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func setupDelegateImpl() {
        delegateImpl.selectedIndexPath = selectedIndexPath
        delegateImpl.scrollViewDidScroll = { [weak self] scrollView in
            self?.handleScrollViewDidScroll(scrollView)
        }
    }
    
    private func handleScrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerPoint = CGPoint(
            x: scrollView.bounds.midX + scrollView.contentOffset.x,
            y: scrollView.bounds.midY
        )
        
        guard let collectionView = scrollView as? UICollectionView else {
            return
        }
        
        var closestIndexPath: IndexPath?
        var minDistance = CGFloat.greatestFiniteMagnitude
        
        for cell in collectionView.visibleCells {
            let cellCenter = collectionView.convert(cell.center, to: collectionView.superview)
            let distance = abs(cellCenter.x - centerPoint.x)
            
            if distance < minDistance {
                minDistance = distance
                closestIndexPath = collectionView.indexPath(for: cell)
            }
        }
        
        if let closestIndexPath {
            selectedIndexPath = closestIndexPath
        }
    }
}

// MARK: - GoalViewDelegate

extension GoalViewController: GoalViewDelegate {
    func goalView(_ view: GoalView, didTapActionButton button: LoadableButton) {
        authRegisterProvider.updateGoal(with: selectedGoal)
        
        guard let registerRequest = authRegisterProvider.request else {
            assertionFailure()
            return
        }
        
        button.isLoading = true
        Task { [weak self, manager = authManager] in
            defer {
                button.isLoading = false
            }
            
            do {
                try await manager.register(with: registerRequest)
                
                self?.onFinish?()
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
}
