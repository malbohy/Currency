//
//  UIViewExtenstions.swift
//  AccessabilityIdExtenstions
//
//  Created by mohamed albohy on 07/07/2021.
//

import UIKit

public extension UILabel {
    
    func calculateMaxLines(width: CGFloat) -> Int {
          let maxSize = CGSize(width: width, height: CGFloat(Float.infinity))
          let charSize = font.lineHeight
          let text = (self.text ?? "") as NSString
          let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin,
                                           attributes: [NSAttributedString.Key.font: font ?? UIFont()],
                                           context: nil)
          let linesRoundedUp = Int(ceil(textSize.height/charSize))
          return linesRoundedUp
      }
}

