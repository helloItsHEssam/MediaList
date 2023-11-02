//
//  NetworkError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case cannotConnectToServer
    case cannotParseJson
    case badUrl
    case cannotFetchImageSize
    case cannotFetchImage
    
    var errorDescription: String? {
        switch self {
        case .cannotConnectToServer: return "You seem to be offline!"
        case .cannotParseJson: return "Unexpected error"
        case .badUrl: return "Bad Url"
        case .cannotFetchImageSize: return "Cannot fetch image size"
        case .cannotFetchImage: return "Cannot fetch image"
        }
    }
}
