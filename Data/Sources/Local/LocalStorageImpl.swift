//
//  LocalStorageImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Alamofire
import UIKit
import Common

final public class LocalStorageImpl: LocalStorage {
    
    public init() {}
    
    public func fetchImageSize(imageUrl urlString: String) async throws -> Common.PreviewMediaSizeDTO {
        let image = try await self.fetchImage(imageUrl: urlString)
        return .init(width: image.size.width, height: image.size.height)
    }
    
    public func fetchImage(imageUrl urlString: String) async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ continuation in
            
            let fileManger = FileManager.default
            guard let documentsDirectory = fileManger.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                continuation.resume(throwing: LocalError.cannotFetchImage)
                return
            }
            
            guard let fileName = urlString.extractFileName() else {
                continuation.resume(throwing: LocalError.cannotFetchImage)
                return
            }
            
            let fileURL = documentsDirectory.appendingPathComponent(fileName + ".png")
            
            guard fileManger.fileExists(atPath: fileURL.path) else {
                continuation.resume(throwing: LocalError.cannotFetchImage)
                return
            }
            
            guard let image = UIImage(contentsOfFile: fileURL.path) else {
                continuation.resume(throwing: LocalError.cannotFetchImage)
                return
            }
            
            continuation.resume(returning: image)
        })
    }
    
    public func saveImageToDisk(imageUrl urlString: String, image: UIImage) async throws {
        return try await withCheckedThrowingContinuation({ continuation in
            guard let imageData = image.pngData() else {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDisk)
                return
            }
            
            let fileManger = FileManager.default
            guard let documentsDirectory = fileManger.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDisk)
                return
            }
            
            guard let fileName = urlString.extractFileName() else {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDisk)
                return
            }
            
            let fileURL = documentsDirectory.appendingPathComponent(fileName + ".png")
            
            guard !fileManger.fileExists(atPath: fileURL.path) else {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDiskBecauseOfImageAlreadyExists)
                return
            }
            
            do {
                try imageData.write(to: fileURL)
                continuation.resume()

            } catch {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDisk)
            }
        })
    }
}
