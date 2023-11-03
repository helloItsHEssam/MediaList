//
//  ViewModelFactory.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation

class ViewModelFactory {
    
    private var container: DIContainer!
    
    static let shared = ViewModelFactory()
    
    private init() {}
    
    func register(DIContainer container: DIContainer) {
        self.container = container
    }

    func createMediaViewModel() -> MediaViewModel {
        guard container != nil else {
            fatalError("Register DIContainer to Enable ViewModel Creation")
        }
        
        let mediaUseCase = container.createMediaUseCase()
        return .init(mediaUseCase: mediaUseCase)
    }
}
