//
//  MediaUseCaseImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Combine
import SwiftUI

public class MediaUseCaseImpl: MediaUseCase {

    private var mediaRepository: MediaRepository
    private var imageRepository: ImageRepository
    
    public init(mediaRepository: MediaRepository, imageRepository: ImageRepository) {
        self.mediaRepository = mediaRepository
        self.imageRepository = imageRepository
    }
    
    public func fetchMediaList() -> AnyPublisher<[Media], DomainError> {
        return AnyPublisher { [weak self] in
            guard let self else { throw DomainError.cannotFetchMediaList }
            
            do {
                let mediaList = try await self.mediaRepository.fetchMediaList()
                return await self.fetchMediaPreviewSize(forMediaList: mediaList)
            } catch {
                throw DomainError.cannotFetchMediaList
            }
        }
    }

    private func fetchMediaPreviewSize(forMediaList mediaList: [Media]) async -> [Media] {
        return await withTaskGroup(of: Media.self,
                      returning: [Media].self) { [weak self] taskGroup in
            guard let self else { return mediaList }
            
            var mediaListWithSize = mediaList
            
            let totalSize = mediaList.count
            let batchSize = totalSize < 4 ? totalSize : 4

            for index in 0 ..< batchSize {
                taskGroup.addTask {
                    var media = await self.fetchPreviewImageSize(forMedia: mediaList[index])
                    media.indexAtList = index
                    return media
                }
            }
            
            var index = batchSize
            
            for await media in taskGroup {
                mediaListWithSize[media.indexAtList] = media
                
                if index < totalSize {
                    taskGroup.addTask { [index] in
                        var media = await self.fetchPreviewImageSize(forMedia: mediaList[index])
                        media.indexAtList = index
                        return media
                    }
                    
                    index += 1
                }
            }
            
            return mediaListWithSize
        }
    }
    
    private func defaultPreviewSize() -> PreviewMediaSize {
        .init(width: 200, height: 100)
    }
    
    private func fetchPreviewImageSize(forMedia media: Media) async -> Media {
        var newMediaWithSize = media
        var size: PreviewMediaSize?
        
        guard let imageUrl = media.previewLink else {
            newMediaWithSize.update(PreviewMediaSize: self.defaultPreviewSize())
            return newMediaWithSize
        }
        
        do {
            // check local
            let _ = try await self.imageRepository.fetchImageFromLocal(imageUrl: imageUrl)
            size = try? await self.imageRepository.fetchImageSizeFromLocal(imageUrl: imageUrl)
            
        } catch { // does not exist on Local.
            size = try? await self.imageRepository.fetchImageSizeFromServer(imageUrl: imageUrl)
        }

        newMediaWithSize.update(PreviewMediaSize: size ?? self.defaultPreviewSize())
        return newMediaWithSize
    }
    
    public func fetchImage(withImageUrl imageUrl: String) -> AnyPublisher<Image, DomainError> {
        return AnyPublisher { [weak self] in
            guard let self else { throw DomainError.cannotRetrieveImage }
            
            var uiImage: UIImage
            do {
                uiImage = try await self.imageRepository.fetchImageFromLocal(imageUrl: imageUrl)
            } catch {
                guard let imageFromServer = try? await self.imageRepository
                    .fetchImageFromServer(imageUrl: imageUrl) else {
                    throw DomainError.cannotRetrieveImage
                }
                
                uiImage = imageFromServer
                
                // does not matter if could not save into disk
                try? await self.imageRepository.saveImageToDisk(imageUrl: imageUrl, image: uiImage)
            }
            
            let image = Image(uiImage: uiImage)
            return image
        }
    }
}
