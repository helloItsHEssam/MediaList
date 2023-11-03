//
//  MediaViewModel.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation
import Combine
import Domain

class MediaViewModel: ObservableObject {
    
    @Published private(set) var viewState: ViewState = .loading
    private let useCase: MediaUseCase
    
    init(mediaUseCase useCase: MediaUseCase) {
        self.useCase = useCase
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.viewState = .result
            self.viewState = .error(alertContent: .init(message: "Error!"))
        }
    }
}
