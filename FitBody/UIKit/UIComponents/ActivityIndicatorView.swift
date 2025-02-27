import UIKit

final class ActivityIndicatorView: UIView {
    override var intrinsicContentSize: CGSize {
        bounds.size
    }
    
    override var bounds: CGRect {
        didSet {
            guard
                oldValue != bounds,
                isAnimating
            else {
                return
            }
            
            configureAnimation()
        }
    }
    
    private(set) var isAnimating = false
    
    private let thickness: CGFloat
    var color: UIColor
    
    convenience init(size: Size, color: UIColor) {
        switch size {
        case .extraSmall:
            self.init(size: CGSize(width: 16, height: 16), thickness: 2, color: color)
        case .small:
            self.init(size: CGSize(width: 20, height: 20), thickness: 2, color: color)
        case .medium:
            self.init(size: CGSize(width: 24, height: 24), thickness: 2, color: color)
        case .large:
            self.init(size: CGSize(width: 40, height: 40), thickness: 3, color: color)
        }
    }
    
    private init(size: CGSize, thickness: CGFloat, color: UIColor) {
        self.thickness = thickness
        self.color = color
        super.init(
            frame: CGRect(origin: .zero, size: size)
        )
        
        isHidden = true
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        nil
    }
    
    func startAnimating() {
        guard !isAnimating else {
            return
        }
        
        isHidden = false
        isAnimating = true
        layer.speed = 1
        configureAnimation()
    }
    
    func stopAnimating() {
        guard isAnimating else {
            return
        }
        
        isHidden = true
        isAnimating = false
        layer.sublayers = nil
    }
    
    private func configureAnimation() {
        layer.sublayers = nil
        
        let beginTime = 0.5
        let strokeStartDuration = 1.2
        let strokeEndDuration = 0.7
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.byValue = Float.pi * 2
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = strokeEndDuration
        strokeEndAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeEndAnimation.fromValue = 0
        strokeEndAnimation.toValue = 1
        
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = strokeStartDuration
        strokeStartAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 0.0, 0.2, 1.0)
        strokeStartAnimation.fromValue = 0
        strokeStartAnimation.toValue = 1
        strokeStartAnimation.beginTime = beginTime
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [rotationAnimation, strokeEndAnimation, strokeStartAnimation]
        groupAnimation.duration = strokeStartDuration + beginTime
        groupAnimation.repeatCount = .infinity
        groupAnimation.isRemovedOnCompletion = false
        groupAnimation.fillMode = .forwards
        
        let size = frame.size
        let circle = makeCircle(with: size, and: thickness)
        let frame = CGRect(
            x: (layer.bounds.width - size.width) / 2,
            y: (layer.bounds.height - size.height) / 2,
            width: size.width,
            height: size.height
        )
        
        circle.frame = frame
        circle.add(groupAnimation, forKey: "animation")
        layer.addSublayer(circle)
    }
    
    private func makeCircle(with size: CGSize, and lineWidth: CGFloat) -> CALayer {
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        
        path.addArc(
            withCenter: CGPoint(x: size.width / 2, y: size.height / 2),
            radius: size.width / 2,
            startAngle: -(.pi / 2),
            endAngle: .pi + .pi / 2,
            clockwise: true
        )
        
        layer.backgroundColor = nil
        layer.fillColor = nil
        layer.frame = CGRect(origin: .zero, size: size)
        layer.lineWidth = lineWidth
        layer.path = path.cgPath
        layer.strokeColor = color.cgColor
        
        return layer
    }
}

extension ActivityIndicatorView {
    enum Size: Sendable {
        case extraSmall
        case small
        case medium
        case large
    }
}
