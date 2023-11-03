//
//  ImageRepositoryImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import UIKit
import Domain
import Network
import Common
import Local

public class ImageRepositoryImpl: ImageRepository {
    
    private var api: Api
    private var localStorage: LocalStorage
    private var previewImageSizeMapper: PreviewMediaSizeMapper
    
    public init(api: Api, localStorage: LocalStorage) {
        self.api = api
        self.localStorage = localStorage
        self.previewImageSizeMapper = .init()
    }
    
    public func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        let data = try await api.fetchImageData(route: .fetchImage(imageUrl: url))
        guard let image = UIImage(data: data) else {
            throw ImageError.cannotCreateImageFromData
        }

        return image
    }
    
    public func fetchImageFromLocal(imageUrl url: String) async throws -> UIImage {
        return try await self.localStorage.fetchImage(imageUrl: url)
    }
    
    public func saveImageToDisk(imageUrl url: String, image: UIImage) async throws {
        try await self.localStorage.saveImageToDisk(imageUrl: url, image: image)
    }
    
    public func fetchImageSizeFromServer(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        let previewSizeDto = try await self.api.fetchImageSize(imageUrl: url)
        return previewImageSizeMapper.mapDtoToEntity(input: previewSizeDto)
    }
    
    public func fetchImageSizeFromLocal(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        let previewSizeDto = try await self.localStorage.fetchImageSize(imageUrl: url)
        return previewImageSizeMapper.mapDtoToEntity(input: previewSizeDto)
    }
    
    public func resetCache() {
        
    }
}
