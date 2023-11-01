//
//  Raleway.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import Foundation
import SwiftUI

public enum Raleway: CaseIterable, CustomStringConvertible {
    
    case regular
    case semiBold
    case extraBold
    
    public var fileExtension: String {
        return "ttf"
    }
    
    public var description: String {
        var weight: String
        switch self {
        case .regular: weight = "Regular"
        case .semiBold: weight = "SemiBold"
        case .extraBold: weight = "ExtraBold"
        }
        
        return "Raleway-" + weight
    }
    
    public func customFont(basedOnFontSize size: CGFloat) -> Font {
        let name = String(describing: self)
        return Font.custom(name, size: size)
    }
    
    public func customFont(basedOnTextStyle textStyle: Font.TextStyle) -> Font {
        let name = String(describing: self)
        let size = fontSize(basedOnTextStyle: textStyle)
        return Font.custom(name, size: size)
    }
    
    func fontSize(basedOnTextStyle textStyle: Font.TextStyle) -> CGFloat {
        switch self {
        case .extraBold: return ExtraBoldFontSize(basedOnTextStyle: textStyle)
        case .semiBold: return semiBoldFontSize(basedOnTextStyle: textStyle)
        case .regular: return regularFontSize(basedOnTextStyle: textStyle)
        }
    }
}

fileprivate extension Raleway {

    private func semiBoldFontSize(basedOnTextStyle textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
        case .headline: return 22
        case .subheadline: return 18
        default: return 14
        }
    }
    
    private func ExtraBoldFontSize(basedOnTextStyle textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
        case .headline: return 24
        case .subheadline: return 20
        default: return 16
        }
    }
    
    private func regularFontSize(basedOnTextStyle textStyle: Font.TextStyle) -> CGFloat {
        switch textStyle {
        case .title2: return 16
        case .title3: return 12
        default: return 10
        }
    }
}
