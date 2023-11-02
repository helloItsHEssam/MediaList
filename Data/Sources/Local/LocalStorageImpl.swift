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
        fatalError()
    }
    
    public func fetchImage(imageUrl urlString: String) async throws -> UIImage {
        fatalError()
    }
    
    public func saveImageToDisk(imageName name: String, image: UIImage) async throws {
        fatalError()
    }
}

