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
            
            let mediaList = try await self.mediaRepository.fetchMediaList()
            return await fetchMediaPreviewSize(forMediaList: mediaList)
        }
    }

    private func fetchMediaPreviewSize(forMediaList mediaList: [Media]) async -> [Media] {
        return await withTaskGroup(of: Media.self,
                      returning: [Media].self) { [weak self] taskGroup in
            guard let self else { return mediaList }
            
            var mediaListWithSize = [Media]()
            mediaListWithSize.reserveCapacity(mediaList.count)
            
            let totalSize = mediaList.count
            let batchSize = totalSize < 4 ? totalSize : 4

            for index in 0 ..< batchSize {
                taskGroup.addTask {
                    await self.fetchPreviewImageSize(forMedia: mediaList[index])
                }
            }
            
            var index = batchSize
            
            for await media in taskGroup {
                mediaListWithSize.append(media)
                
                if index < totalSize {
                    taskGroup.addTask { [index] in
                        await self.fetchPreviewImageSize(forMedia: mediaList[index])
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
        
        guard let imageName = media.previewLink else {
            newMediaWithSize.update(PreviewMediaSize: self.defaultPreviewSize())
            return newMediaWithSize
        }
        
        do {
            // check local
            let _ = try await self.imageRepository.fetchImageFromLocal(imageName: imageName)
            size = try? await self.imageRepository.fetchImageSizeFromLocal(imageName: imageName)
            
        } catch { // does not exist on Local.
            size = try? await self.imageRepository.fetchImageSizeFromServer(imageUrl: imageName)
        }

        newMediaWithSize.update(PreviewMediaSize: size ?? self.defaultPreviewSize())
        return newMediaWithSize
    }
    
    public func fetchImage(from url: String) -> AnyPublisher<Image, DomainError> {
        return AnyPublisher(taskPriority: .userInitiated) {
            throw DomainError.cannotRetrieveImage
        }
    }
}
