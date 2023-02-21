//
//  Extensions.swift
//  RickMortyApp
//
//  Created by Ricky Austin on 18/02/23.
//

import Foundation
import UIKit
// MARK: - Image
extension UIImage {
    /// Modify `UIImage` size
    ///  - Parameter size: width & height of preferred `UIImage`
    func resize(size: CGSize) -> UIImage? {
        let imageSize = CGSize(width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        let drawingRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: drawingRect)
        let resultingImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultingImage
    }
}

// MARK: - View
extension UIView {
    /// Style for view corner radius in the `Inspectors`
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    /// Style for view border color in the `Inspectors`
    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }

    /// Style for view border width in the `Inspectors`
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// Set element id for UITest
    @IBInspectable
    var accessId: String? {
        get {
            return accessibilityIdentifier
        }
        set {
            isAccessibilityElement = true
            accessibilityIdentifier = newValue
        }
    }
}

// MARK: - Text
extension String {
    /// Convert string by specified date format to another format
    ///  - Parameter from: initial date format , such `"yyyy-MM-dd"`
    ///  - Parameter to: converted date format, such `"dd MMMM yyyy"`
    func convertDateFormat(from startDate: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to endDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = startDate
        let date = formatter.date(from: self)
        
        formatter.dateFormat = endDate
        if let d = date {
            return formatter.string(from: d)
        }
        return "00:00:00"
    }
}
