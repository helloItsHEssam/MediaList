//
//  Api.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import UIKit

public protocol Api {

    func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T
    func fetchImageSize(imageUrl urlString: String) async throws -> PreviewMediaSizeDTO
    func fetchImage(route: ApiRouter) async throws -> UIImage
}
