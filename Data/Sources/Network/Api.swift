//
//  Api.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Common

public protocol Api {

    func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T
    func fetchImageSize(imageUrl urlString: String) async throws -> PreviewMediaSizeDTO
    func fetchImageData(route: ApiRouter) async throws -> Data
}
