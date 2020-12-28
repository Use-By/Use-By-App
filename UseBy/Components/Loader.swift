import Foundation
import UIKit

class LoaderShapeLayer: CAShapeLayer {
    public init(strokeColor: UIColor, lineWidth: CGFloat) {
        super.init()

        self.strokeColor = strokeColor.cgColor
        self.lineWidth = lineWidth
        self.fillColor = UIColor.clear.cgColor
        self.lineCap = .round
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Loader: UIView {
    private let colors: [UIColor]
    private let lineWidth: CGFloat
    private lazy var shapeLayer: LoaderShapeLayer = {
        return LoaderShapeLayer(strokeColor: colors.first!, lineWidth: lineWidth)
    }()

    init(
        lineWidth: CGFloat,
        colors: [UIColor] = [Colors.mainActionColor, Colors.secondaryActionColor]
    ) {
        self.colors = colors
        self.lineWidth = lineWidth

        super.init(frame: .zero)

        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = self.frame.width / 2

        let path = UIBezierPath(ovalIn: CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.width
        ))

        shapeLayer.path = path.cgPath
    }

    func animateStroke() {
        let startAnimation = StrokeAnimation(
            type: .start,
            beginTime: 0.25,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )

        let endAnimation = StrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 1.0,
            duration: 0.75
        )

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = 1
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [startAnimation, endAnimation]

        shapeLayer.add(strokeAnimationGroup, forKey: nil)

            let colorAnimation = StrokeColorAnimation(
                colors: colors.map { $0.cgColor },
                duration: strokeAnimationGroup.duration * Double(colors.count)
            )

        shapeLayer.add(colorAnimation, forKey: nil)

        self.layer.addSublayer(shapeLayer)
    }

    var isAnimating: Bool = false {
        didSet {
            if isAnimating {
                self.animateStroke()
            } else {
                self.shapeLayer.removeFromSuperlayer()
                self.layer.removeAllAnimations()
            }
        }
    }
}
