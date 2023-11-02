//
//  DomainError.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

public enum DomainError: Error {
    
    case cannotFetchMediaList
    case cannotRetrieveImage
    
    var errorDescription: String? {
        switch self {
        case .cannotRetrieveImage:
            return "Image retrieval failed."
            
        case .cannotFetchMediaList:
            return "Failed to fetch MediaList."
        }
    }
}
