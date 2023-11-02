//
//  ImageError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

enum ImageError: Error, LocalizedError {
    
    case cannotCreateImageFromData
    
    var errorDescription: String? {
        return "Cannot create image from Data"
    }
}
