//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//
import UIKit

public extension UIImage {
    
    func imageWithFixedOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? self
    }
}

// MARK: - ResizeImage accroding to cropping attributes (mainly created for Nagwa Readers App)
public extension UIImage {
    
    func resized(width:CGFloat,
                 height:CGFloat,
                 x11: CGFloat,
                 y11: CGFloat,
                 x12: CGFloat,
                 x21: CGFloat,
                 y21: CGFloat,
                 x22: CGFloat) -> UIImage {
        
        let y12 = (x12 - x11) * 9 / 12 + y11
        let y22 = (x22 - x21) * 9 / 24 + y21
        let s:CGFloat = width/height
        let t: CGFloat = (x12 - x11 - s * (y12 - y11)) / (s * (y22 - y12 - y21 + y11) - (x22 - x12 - x21 + x11))
        let x31 = x11 + t * (x21 - x11)
        let y31 = y11 + t * (y21 - y11)
        let x32 = x12 + t * (x22 - x12)
        let y32 = y12 + t * (y22 - y12)
        
        
        let width = x32 - x31
        let height = y32 - y31
        let imageSize = self.size
        let finalImageWidth = min(CGFloat(width), imageSize.width).rounded(.down)
        let finalImageHeight = min(CGFloat(height), imageSize.height).rounded(.down)
        let croppingSpaceRect = CGRect(x: x31, y: y31, width: finalImageWidth, height: finalImageHeight)
        return self.cropImage(rect: croppingSpaceRect)
    }
    
    private func cropImage(rect: CGRect) -> UIImage {
        let cgImage = self.cgImage!
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!, scale: self.scale, orientation: self.imageOrientation)
    }
}
