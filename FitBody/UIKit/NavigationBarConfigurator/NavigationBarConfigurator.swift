import UIKit

final class NavigationBarConfigurator {
    public init() {}

    public func configure(
        navigationBar: UINavigationBar,
        with style: NavigationBarStyle = .default(),
        userInterfaceStyle: UIUserInterfaceStyle = .unspecified
    ) {
        switch style {
        case let .default(needsToDisplayShadow, backgroundColor):
            configureDefaultNavigationBar(navigationBar, needsToDisplayShadow, backgroundColor)
        case .transparent:
            configureTranspartNavigationBar(navigationBar)
        }
        navigationBar.tintColor = Colors.iconPrimary
        navigationBar.overrideUserInterfaceStyle = userInterfaceStyle
    }

    private func configureDefaultNavigationBar(
        _ navigationBar: UINavigationBar,
        _ needsToDisplayShadow: Bool,
        _ backgroundColor: UIColor
    ) {
        navigationBar.layoutMargins.left = 16
        navigationBar.layoutMargins.right = 16
        navigationBar.prefersLargeTitles = true
        navigationBar.scrollEdgeAppearance = makeDefaultNavigationBarAppearance(
            needsToDisplayShadow: false,
            backgroundColor: backgroundColor
        )
        navigationBar.standardAppearance = makeDefaultNavigationBarAppearance(
            needsToDisplayShadow: needsToDisplayShadow,
            backgroundColor: backgroundColor
        )
    }

    private func configureTranspartNavigationBar(_ navigationBar: UINavigationBar) {
        navigationBar.scrollEdgeAppearance = makeTransparentNavigationBarAppearance()
        navigationBar.standardAppearance = makeTransparentNavigationBarAppearance()
    }

    private func makeDefaultNavigationBarAppearance(
        needsToDisplayShadow: Bool,
        backgroundColor: UIColor
    ) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.largeTitleTextAttributes = makeLargeTitleTextAttributes()
        appearance.shadowColor = needsToDisplayShadow ? Colors.fillDivider : nil
        appearance.titleTextAttributes = makeTitleTextAttributes()
        return appearance
    }

    private func makeTransparentNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = makeLargeTitleTextAttributes()
        appearance.titleTextAttributes = makeTitleTextAttributes()
        return appearance
    }

    private func makeLargeTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        [.font: Fonts.title0, .foregroundColor: Colors.textPrimary]
    }

    private func makeTitleTextAttributes() -> [NSAttributedString.Key: Any] {
        [.font: Fonts.title2, .foregroundColor: Colors.textPrimary]
    }
}
