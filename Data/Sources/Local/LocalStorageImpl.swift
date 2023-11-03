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
    
    private let cacheFolder = "imageFolder"
    private let fileManger = FileManager.default
    
    public init() {}
    
    public func fetchImageSize(imageUrl urlString: String) async throws -> Common.PreviewMediaSizeDTO {
        let image = try await self.fetchImage(imageUrl: urlString)
        return .init(width: image.size.width, height: image.size.height)
    }
    
    public func fetchImage(imageUrl urlString: String) async throws -> UIImage {
        return try await withCheckedThrowingContinuation({ continuation in

            guard let documentsDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else {
                continuation.resume(throwing: LocalError.cannotFetchImage)
                return
            }
            
            guard let fileName = urlString.extractFileName() else {
                continuation.resume(throwing: LocalError.cannotFetchImage)
                return
            }
            
            var fileURL = documentsDirectory.appendingPathComponent(cacheFolder)
            fileURL = documentsDirectory.appendingPathComponent(fileName + ".png")
            
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
            
            guard let documentsDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDisk)
                return
            }
            
            guard let fileName = urlString.extractFileName() else {
                continuation.resume(throwing: LocalError.cannotSaveImageIntoDisk)
                return
            }
            
            createCacheImageDirectoryIfNeeded()
            var fileURL = documentsDirectory.appendingPathComponent(cacheFolder)
            fileURL = fileURL.appendingPathComponent(fileName + ".png")
            
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
    
    public func resetCache() {
        guard let documentsDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(cacheFolder)
        try? fileManger.removeItem(atPath: fileURL.path)
    }
    
    private func createCacheImageDirectoryIfNeeded() {
        
        guard let documentsDirectory = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(cacheFolder)
        
        guard !fileManger.fileExists(atPath: fileURL.path) else {
            return
        }
        
        do {
            try fileManger.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true)
        }
        catch {
            print(error)
        }
        
    }
}
