//
//  LocalError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

enum LocalError: Error, LocalizedError {
    
    case cannotSaveImageIntoDisk
    case cannotSaveImageIntoDiskBecauseOfImageAlreadyExists
    case cannotFetchImageSize
    case cannotFetchImage
    
    var errorDescription: String? {
        switch self {
        case .cannotSaveImageIntoDisk: return "Cannot save image into disk"
        case .cannotSaveImageIntoDiskBecauseOfImageAlreadyExists:
            return "Cannot save image into disk because of Image already exist!"
        case .cannotFetchImageSize: return "Cannot fetch image size"
        case .cannotFetchImage: return "Cannot fetch image"
        }
    }
}
