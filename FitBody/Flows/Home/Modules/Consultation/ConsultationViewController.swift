import UIKit
import Resolver

// MARK: - ConsultationViewController

final class ConsultationViewController: BaseViewController {
    private var response: String? {
        didSet {
            mainView.updateResponse(response, animated: true)
        }
    }
    
    private lazy var mainView = ConsultationView(with: self)
    
    @Injected private var geminiProvider: GeminiProvider
    
    override func loadView() {
        view = mainView
    }
    
    override func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else {
            assertionFailure()
            return
        }
        
        NavigationBarConfigurator().configure(navigationBar: navigationBar)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Consultation"
    }
}

// MARK: - ConsultationTextInputViewDelegate

extension ConsultationViewController: ConsultationTextInputViewDelegate {
    func consultationTextInputView(
        _ view: ConsultationTextInputView,
        didTapActionButton button: LoadableButton
    ) {
        guard let text = view.text else {
            assertionFailure()
            return
        }
        
        let request = GeminiRequest(
            with: getPrompt(with: text)
        )
        
        button.isLoading = true
        Task { [weak self, geminiProvider] in
            defer {
                button.isLoading = false
            }
            
            do {
                let text = try await geminiProvider.get(with: request)
                
                guard let self else {
                    return
                }
                
                response = text
                mainView.bottomView.reset()
            } catch {
                print("ERROR: ", error.localizedDescription)
            }
        }
    }
    
    private func getPrompt(with issue: String) -> String {
        """
        Act as an informational resource providing general knowledge about health conditions and recovery. A user is seeking general information regarding rehabilitation for \(issue).

        Please provide a summary covering:
        1.  A brief, general description of what rehabilitation for this condition typically involves.
        2.  Common types of therapies or approaches often used (e.g., physical therapy, occupational therapy, specific techniques - describe briefly).
        3.  General goals of rehabilitation for someone with this issue.
        4.  Types of healthcare professionals who typically guide rehabilitation for this condition.
        
        **Formatting Instructions:** Please format the entire response as plain text. Do not use any markdown bold formatting (avoid using double asterisks like **this**). Ensure lists use standard numbering (1., 2., etc.) without additional markdown.

        **CRITICAL SAFETY DISCLAIMER:** Please begin your response with a clear and prominent statement that you are an AI, this information is for general knowledge and educational purposes ONLY, it is NOT medical advice, and it CANNOT replace a personalized assessment, diagnosis, or treatment plan from a qualified healthcare professional (like a doctor, physical therapist, or specialist). Strongly advise consulting with appropriate professionals before starting or changing any rehabilitation or exercise program. Do not provide specific exercise instructions.
        """
    }
}
