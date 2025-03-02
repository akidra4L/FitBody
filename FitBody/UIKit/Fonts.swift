import UIKit

enum Fonts: Sendable {
    static var title0: UIFont {
        .boldSystemFont(ofSize: 28)
    }
    
    static var title1: UIFont {
        .boldSystemFont(ofSize: 22)
    }
    
    static var title2: UIFont {
        .boldSystemFont(ofSize: 18)
    }
    
    public static var title3: UIFont {
        .systemFont(ofSize: 16, weight: .semibold)
    }

    public static var title4: UIFont {
        .systemFont(ofSize: 18, weight: .semibold)
    }

    public static var title5: UIFont {
        .systemFont(ofSize: 18, weight: .medium)
    }

    public static var title6: UIFont {
        .systemFont(ofSize: 14, weight: .semibold)
    }
    
    static var body1: UIFont {
        .systemFont(ofSize: 16, weight: .semibold)
    }
    
    static var body2: UIFont {
        .systemFont(ofSize: 16, weight: .medium)
    }

    static var body3: UIFont {
        .systemFont(ofSize: 16, weight: .regular)
    }
    
    static var headline1: UIFont {
        .systemFont(ofSize: 14, weight: .medium)
    }

    static var headline2: UIFont {
        .systemFont(ofSize: 14, weight: .regular)
    }

    static var headline3: UIFont {
        .systemFont(ofSize: 12, weight: .semibold)
    }

    static var headline4: UIFont {
        .systemFont(ofSize: 12, weight: .medium)
    }

    static var headline5: UIFont {
        .systemFont(ofSize: 12, weight: .regular)
    }

    static var headline6: UIFont {
        .systemFont(ofSize: 10, weight: .medium)
    }

    static var headline7: UIFont {
        .systemFont(ofSize: 10, weight: .regular)
    }
}
