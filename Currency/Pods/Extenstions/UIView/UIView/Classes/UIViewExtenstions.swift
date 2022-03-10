//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import UIKit
public extension UIView {
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    public var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    public var parentViewController: UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.parentViewController
        } else {
            return nil
        }
    }
    
    func loadNib() {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.addSubview(view)
        }
    }
}

// MARK: - Layout
public extension UIView {
    
    func pinToSuperViewEdges(with edgeInsets: UIEdgeInsets = UIEdgeInsets.zero) {
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                                     toItem: self.superview, attribute: .top, multiplier: 1, constant: edgeInsets.top)
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                                        toItem: self.superview, attribute: .bottom, multiplier: 1, constant: edgeInsets.bottom)
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
                                         toItem: self.superview, attribute: .leading, multiplier: 1, constant: edgeInsets.left)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
                                          toItem: self.superview, attribute: .trailing, multiplier: 1, constant: edgeInsets.right)
        self.superview?.addConstraints([top, bottom, leading, trailing])
    }
}

// MARK: - Animation
public extension UIView {
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
}

public extension UIView {
    
    // there can be other views between `subview` and `self`
    func convertedFrame(fromSubview subview: UIView) -> CGRect? {
        // check if `subview` is a subview of self00
        guard subview.isDescendant(of: self) else {
            return nil
        }
        
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview!.superview == nil {
                break
            } else {
                superview = superview!.superview
            }
        }
        return superview!.convert(frame, to: self)
    }
}

// MARK: - DropShadow
public extension UIView {
    
    func dropShadow(shadowColor: UIColor = .black,
                    shadowOpacity: Float = 0.1,
                    shadowOffset: CGSize = .zero,
                    shadowRadius: CGFloat = 1,
                    masksToBounds: Bool = false) {
        layer.masksToBounds = masksToBounds
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}


public extension UIView {
    func subviewsRecursive() -> [UIView] {
        return subviews + subviews.flatMap { $0.subviewsRecursive() }
    }
}

public extension UIView {

    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func instantiateFromNib() -> Self {
        let view = self.nib.instantiate(withOwner: nil).first as! Self
        return view
    }
    
    func centerViewToSuperView() {
        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self.superview,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self.superview,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.superview?.addConstraints([centerX, centerY])
    }
}

public extension UIView {
    
    func addSwipeGestures(direction: UISwipeGestureRecognizer.Direction, swipeAction: Selector) {
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: swipeAction)
            swipeGesture.direction = direction
            self.addGestureRecognizer(swipeGesture)
    }
}

public extension UIView {
    func isSwipe(touches: Set<UITouch>, touchStart: (location: CGPoint, time: TimeInterval),
                 minDistance: CGFloat,
                 minSpeed: CGFloat,
                 maxSpeed: CGFloat) -> Bool {
        var swiped = false
        if let touch = touches.first {
            let location = touch.location(in:self)
            let dx = location.x - touchStart.location.x
            let dy = location.y - touchStart.location.y
            let distance = sqrt(dx*dx+dy*dy)
            if distance > minDistance {
                let deltaTime = CGFloat(touch.timestamp - touchStart.time)
                let speed = distance / deltaTime
                if speed >= minSpeed && speed <= maxSpeed {
                    swiped = true
                }
            }
        }
        return swiped
    }
}
