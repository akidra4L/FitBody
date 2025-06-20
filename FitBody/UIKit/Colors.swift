import UIKit

enum Colors: Sendable {}

// MARK: - Button

extension Colors {
    static var buttonSecondary: UIColor {
        UIColor(named: "button-secondary")!
    }
}

// MARK: - Fill

extension Colors {
    static var fillBackgroundPrimary: UIColor {
        UIColor(named: "fill-background-primary")!
    }
    
    static var fillBackgroundSecondary: UIColor {
        UIColor(named: "fill-background-secondary")!
    }
    
    static var fillDivider: UIColor {
        UIColor(named: "fill-divider")!
    }
    
    static var fillInputPressed: UIColor {
        UIColor(named: "fill-input-pressed")!
    }
    
    static var fillInput: UIColor {
        UIColor(named: "fill-input")!
    }
    
    static var fillPrimaryDisabled: UIColor {
        UIColor(named: "fill-primary-disabled")!
    }
    
    static var fillPrimaryPressed: UIColor {
        UIColor(named: "fill-primary-pressed")!
    }
    
    static var fillPrimary: UIColor {
        UIColor(named: "fill-primary")!
    }
    
    static var fillShadowPrimary: UIColor {
        UIColor(named: "fill-shadow-primary")!
    }
    
    static var fillStrokePressed: UIColor {
        UIColor(named: "fill-stroke-pressed")!
    }
    
    static var fillStroke: UIColor {
        UIColor(named: "fill-stroke")!
    }
}

// MARK: - Icon

extension Colors {
    static var iconPrimary: UIColor {
        UIColor(named: "icon-primary")!
    }
    
    static var iconSecondary: UIColor {
        UIColor(named: "icon-secondary")!
    }
}

// MARK: - Text

extension Colors {
    static var textError: UIColor {
        UIColor(named: "text-error")!
    }
    
    static var textPrimary: UIColor {
        UIColor(named: "text-primary")!
    }
    
    static var textSecondary: UIColor {
        UIColor(named: "text-secondary")!
    }
    
    static var textTertiary: UIColor {
        UIColor(named: "text-tertiary")!
    }
}
