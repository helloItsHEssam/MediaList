//
//  LocalStorage.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import UIKit
import Common

public protocol LocalStorage {

    func fetchImageSize(imageUrl urlString: String) async throws -> PreviewMediaSizeDTO
    func fetchImage(imageUrl urlString: String) async throws -> UIImage
    func saveImageToDisk(imageUrl urlString: String, image: UIImage) async throws
    func resetCache()
}
