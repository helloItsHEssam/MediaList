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
    func fetchImageFromLocal(imageName name: String) async throws -> UIImage
    func saveImageToDisk(imageName name: String, image: UIImage) async throws
    func fetchImageSizeFromServer(imageUrl url: String) async throws -> PreviewMediaSize
    func fetchImageSizeFromLocal(imageName name: String) async throws -> PreviewMediaSize
}
