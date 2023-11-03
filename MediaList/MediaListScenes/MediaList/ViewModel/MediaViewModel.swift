//
//  MediaViewModel.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation
import Combine
import Domain
import SwiftUI

class MediaViewModel: ObservableObject {
    typealias BackImage = (Image) -> Void
    
    @Published private(set) var viewState: ViewState = .loading
    @Published var mediaList: [Media] = []
    private let useCase: MediaUseCase
    private var subscriptions = Set<AnyCancellable>()
    
    deinit {
        cancelAllPendingTask()
    }
    
    init(mediaUseCase useCase: MediaUseCase) {
        self.useCase = useCase
    }
    
    private func cancelAllPendingTask() {
        subscriptions.removeAll()
    }
    
    private func updateViewState(newState viewState: ViewState) {
        self.viewState = viewState
    }
    
    func fetchMediaList() {
        updateViewState(newState: .loading)
        
        useCase.fetchMediaList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    let alertContent = AlertContent(message: error.localizedDescription)
                    self.updateViewState(newState: .error(alertContent: alertContent))
                case .finished: break
                }
            } receiveValue: { [weak self] mediaList in
                self?.mediaList = mediaList
                self?.updateViewState(newState: .result)
            }
            .store(in: &subscriptions)
    }
    
    func fetchMediaImage(WithUrlImage urlImage: String?, previewImage: @escaping BackImage) {
        guard let urlImage else {
            previewImage(Image("imageFailed"))
            return
        }

        useCase.fetchImage(WithImageName: urlImage)
            .retry(3)
            .replaceError(with: Image("imageFailed"))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { image in
                previewImage(image)
            })
            .store(in: &subscriptions)
    }
}
