//
//  DIContainer.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation
import Domain

protocol DIContainer {
    
    func createMediaUseCase() -> MediaUseCase
}
