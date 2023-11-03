//
//  ViewState.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation

enum ViewState {
    
    case loading
    case result
    case error(alertContent: AlertContent)
}
