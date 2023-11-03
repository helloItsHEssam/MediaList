//
//  ImageRepository.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import UIKit

public protocol ImageRepository {
    
    func fetchImageFromServer(imageUrl url: String) async throws -> UIImage
    func fetchImageFromLocal(imageUrl url: String) async throws -> UIImage
    func saveImageToDisk(imageUrl url: String, image: UIImage) async throws
    func fetchImageSizeFromServer(imageUrl url: String) async throws -> PreviewMediaSize
    func fetchImageSizeFromLocal(imageUrl url: String) async throws -> PreviewMediaSize
}
