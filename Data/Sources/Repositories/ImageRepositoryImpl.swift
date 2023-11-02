//
//  ImageRepositoryImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import UIKit
import Domain

public class ImageRepositoryImpl: ImageRepository {
    
    public func fetchImageFromServer(imageUrl url: String) async throws -> UIImage {
        fatalError()
    }
    
    public func fetchImageFromLocal(imageName name: String) async throws -> UIImage {
        fatalError()
    }
    
    public func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        fatalError()
    }
    
    public func fetchImageSizeFromServer(imageUrl url: String) async throws -> Domain.PreviewMediaSize {
        fatalError()
    }
    
    public func fetchImageSizeFromLocal(imageName name: String) async throws -> Domain.PreviewMediaSize {
        fatalError()
    }
}
