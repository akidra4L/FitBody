import UIKit

final class NavigationBarConfigurator {
    public init() {}

    public func configure(
        navigationBar: UINavigationBar,
        with style: NavigationBarStyle = .default(),
        userInterfaceStyle: UIUserInterfaceStyle = .unspecified
    ) {
        switch style {
        case let .default(needsToDisplayShadow, backgroundColor, foregroundColor):
            configureDefaultNavigationBar(navigationBar, needsToDisplayShadow, backgroundColor, foregroundColor)
        case .transparent:
            configureTranspartNavigationBar(navigationBar)
        }
        navigationBar.tintColor = Colors.iconPrimary
        navigationBar.overrideUserInterfaceStyle = userInterfaceStyle
    }

    private func configureDefaultNavigationBar(
        _ navigationBar: UINavigationBar,
        _ needsToDisplayShadow: Bool,
        _ backgroundColor: UIColor,
        _ foregroundColor: UIColor
    ) {
        navigationBar.layoutMargins.left = 16
        navigationBar.layoutMargins.right = 16
        navigationBar.prefersLargeTitles = true
        navigationBar.scrollEdgeAppearance = makeDefaultNavigationBarAppearance(
            needsToDisplayShadow: false,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor
        )
        navigationBar.standardAppearance = makeDefaultNavigationBarAppearance(
            needsToDisplayShadow: needsToDisplayShadow,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor
        )
    }

    private func configureTranspartNavigationBar(_ navigationBar: UINavigationBar) {
        navigationBar.scrollEdgeAppearance = makeTransparentNavigationBarAppearance()
        navigationBar.standardAppearance = makeTransparentNavigationBarAppearance()
    }

    private func makeDefaultNavigationBarAppearance(
        needsToDisplayShadow: Bool,
        backgroundColor: UIColor,
        foregroundColor: UIColor
    ) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.largeTitleTextAttributes = makeLargeTitleTextAttributes(foregroundColor: foregroundColor)
        appearance.shadowColor = needsToDisplayShadow ? Colors.fillDivider : nil
        appearance.titleTextAttributes = makeTitleTextAttributes(foregroundColor: foregroundColor)
        return appearance
    }

    private func makeTransparentNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithTransparentBackground()
        appearance.largeTitleTextAttributes = makeLargeTitleTextAttributes()
        appearance.titleTextAttributes = makeTitleTextAttributes()
        return appearance
    }

    private func makeLargeTitleTextAttributes(
        foregroundColor: UIColor = Colors.textPrimary
    ) -> [NSAttributedString.Key: Any] {
        [.font: Fonts.title0, .foregroundColor: foregroundColor]
    }

    private func makeTitleTextAttributes(
        foregroundColor: UIColor = Colors.textPrimary
    ) -> [NSAttributedString.Key: Any] {
        [.font: Fonts.title2, .foregroundColor: foregroundColor]
    }
}
