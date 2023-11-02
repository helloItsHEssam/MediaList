//
//  MockRepository.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import UIKit
@testable import Domain

class MediaRepositoryErrorMock: MediaRepository {
    func fetchMediaList() async throws -> [Domain.Media] {
        throw DomainError.cannotFetchMediaList // repositry can throw any error
    }
}

class MediaRepositoryMock: MediaRepository {
    func fetchMediaList() async throws -> [Domain.Media] {
        return await withCheckedContinuation { continuation in
            let mediaItem1 = Media.init(title: "title 1", type: .image,
                                        previewLink: "1.jpg", mediaLink: "1.jpg")
            let mediaItem2 = Media.init(title: "title 2", type: .video,
                                        previewLink: "2.jpg", mediaLink: "2.mp4")
            let list = [mediaItem1, mediaItem2]
            continuation.resume(returning: list)
        }
    }
}

class ImageRepositoryImageSizeFromServerMock: ImageRepository {
    func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        fatalError("does not matter")
    }
    
    func fetchImageFromLocal(imageName name: String) async throws -> UIImage {
        throw DomainError.cannotRetrieveImage
    }
    
    func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        fatalError("does not matter")
    }
    
    func fetchImageSizeFromServer(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        return .init(width: 100, height: 200)
    }
    
    func fetchImageSizeFromLocal(imageName name: String) async throws -> Domain.PreviewMediaSize {
        fatalError("does not matter")
    }
}

class ImageRepositoryImageSizeFromServerErrorMock: ImageRepositoryImageSizeFromServerMock {
    override func fetchImageSizeFromServer(imageUrl url: String) async throws -> PreviewMediaSize {
        throw DomainError.cannotRetrieveImage
    }
}

class ImageRepositoryImageSizeFromLocalMock: ImageRepository {
    func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        fatalError("does not matter")
    }
    
    func fetchImageFromLocal(imageName name: String) async throws -> UIImage {
        return UIImage()
    }
    
    func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        fatalError("does not matter")
    }
    
    func fetchImageSizeFromServer(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        fatalError("does not matter")
    }
    
    func fetchImageSizeFromLocal(imageName name: String) async throws -> Domain.PreviewMediaSize {
        return .init(width: 150, height: 200)
    }
}

class ImageRepositoryImageSizeFromLocalErrorMock: ImageRepositoryImageSizeFromLocalMock {
    override func fetchImageSizeFromLocal(imageName name: String) async throws -> PreviewMediaSize {
        throw DomainError.cannotRetrieveImage
    }
}

class ImageRepositoryFetchImageFailFromServerMock: ImageRepository {
    func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        throw DomainError.cannotRetrieveImage
    }
    
    func fetchImageFromLocal(imageName name: String) async throws -> UIImage {
        throw DomainError.cannotRetrieveImage
    }
    
    func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        throw DomainError.cannotRetrieveImage
    }
    
    func fetchImageSizeFromServer(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        fatalError("does not matter")
    }
    
    func fetchImageSizeFromLocal(imageName name: String) async throws -> Domain.PreviewMediaSize {
        fatalError("does not matter")
    }
}

class ImageRepositoryFetchImageSuccessFromServerMock: ImageRepositoryFetchImageFailFromServerMock {
    override func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        return UIImage()
    }
}

class ImageRepositoryFetchImageSuccessFromLocalMock: ImageRepositoryFetchImageFailFromServerMock {
    override func fetchImageFromLocal(imageName name: String) async throws -> UIImage {
        return UIImage()
    }
}

class ImageRepositoryFailSaveImageToDiskMock: ImageRepositoryFetchImageSuccessFromServerMock {
    override func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        throw DomainError.cannotRetrieveImage
    }
}
