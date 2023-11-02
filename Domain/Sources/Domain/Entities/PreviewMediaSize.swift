//
//  PreviewMediaSize.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import UIKit

public struct PreviewMediaSize {
    
    public enum PreviewOrientation {
        case landscape
        case portrait
    }
    
    public var width: CGFloat
    public var height: CGFloat
    public var orientation: PreviewOrientation {
        return width >= height ? .landscape : .portrait
    }
    
    public init(width: CGFloat, height: CGFloat) {
        self.width = width
        self.height = height
    }
}
