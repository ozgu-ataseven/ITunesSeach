//
//  UIView+Extension.swift
//  ItunesSearchApp
//
//  Created by Özgü Ataseven on 4.05.2022.
//

import class UIKit.UIView
import class UIKit.UIActivityIndicatorView
import class UIKit.UIColor
import class UIKit.NSLayoutConstraint
import struct UIKit.CGFloat
import Foundation

// MARK: - NSLayoutConstraint

extension UIView {
    func centerOfView(subView: UIView) {
        if subView.superview != self {
            addSubview(subView)
        }
        
        subView.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [NSLayoutConstraint]()
        
        constraints.append(subView.centerXAnchor.constraint(equalTo: centerXAnchor))
        constraints.append(subView.centerYAnchor.constraint(equalTo: centerYAnchor))
        
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UIActivityIndicatorView

extension UIView {
    private static let indicatorViewKey = "IndicatorView"
    
    func setLoading(_ show: Bool) {
        if show {
            if subviews.contains(where: { $0.accessibilityIdentifier == UIView.indicatorViewKey }) {
                return
            }
            
            let indicatorView = UIActivityIndicatorView(style: .large)
            indicatorView.accessibilityIdentifier = UIView.indicatorViewKey
            centerOfView(subView: indicatorView)
            indicatorView.startAnimating()
        } else {
            if let indicatorView = subviews.first(where: { $0.accessibilityIdentifier == UIView.indicatorViewKey }) as? UIActivityIndicatorView {
                indicatorView.stopAnimating()
                indicatorView.removeFromSuperview()
            }
        }
    }
}

// MARK: - @IBDesignable

@IBDesignable extension UIView {
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

// MARK: - Bundle

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
