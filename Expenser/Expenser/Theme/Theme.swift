//
//  Theme.swift
//  Expenser
//
//  Created by Dushyant Singh on 11/1/22.
//

import Foundation
import UIKit

struct Theme {
    struct Color {
        static let brickRedColor = UIColor(named: "brickRedColor")
    }
    struct Font {
        static func thinFont(with size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-Thin", size: size)!
        }
        static func boldFont(with size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue-Medium", size: size)!
        }
        static func regularFont(with size: CGFloat) -> UIFont {
            return UIFont(name: "HelveticaNeue", size: size)!
        }
    }
}
