//
//  NavigationRouter.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation
import Domain

enum NavigationRouter: Hashable, Equatable {

    case DetailOfMedia(media: Media)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .DetailOfMedia(let media): hasher.combine(media.id)
        }
        
    }
    
    static func == (lhs: NavigationRouter, rhs: NavigationRouter) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
