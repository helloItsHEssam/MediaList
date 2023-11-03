//
//  DIContainerImpl.swift
//  MediaList
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import Foundation
import Domain
import Network
import Repositories
import Local

final class DIContainerImpl: DIContainer {
    
    private var api: Api = ApiImpl()
    private var localStorage: LocalStorage = LocalStorageImpl()
    
    private func createMediaRepository() -> MediaRepository {
        let mediaRepository = MediaRepositoryImpl(api: self.api)
        return mediaRepository
    }
    
    private func createImageRepository() -> ImageRepository {
        let imageRepository = ImageRepositoryImpl(api: self.api, localStorage: self.localStorage)
        return imageRepository
    }
    
    func createMediaUseCase() -> MediaUseCase {
        let mediaRepository = createMediaRepository()
        let imageRepository = createImageRepository()
        let useCase = MediaUseCaseImpl(mediaRepository: mediaRepository, imageRepository: imageRepository)
        
        return useCase
    }
}
