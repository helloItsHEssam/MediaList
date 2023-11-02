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

public class ImageRepositoryImpl: ImageRepository {
    
    private var api: Api
    private var previewImageSizeMapper: PreviewMediaSizeMapper
    
    public init(api: Api) {
        self.api = api
        self.previewImageSizeMapper = .init()
    }
    
    public func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        return try await api.fetchImage(route: .fetchImage(imageUrl: url))
    }
    
    public func fetchImageFromLocal(imageName name: String) async throws -> UIImage {
        fatalError()
    }
    
    public func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        fatalError()
    }
    
    public func fetchImageSizeFromServer(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        let previewSizeDto = try await self.api.fetchImageSize(imageUrl: url)
        return previewImageSizeMapper.mapDtoToEntity(input: previewSizeDto)
    }
    
    public func fetchImageSizeFromLocal(imageName name: String) async throws -> Domain.PreviewMediaSize {
        fatalError()
    }
}
