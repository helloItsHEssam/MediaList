//
//  Api.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

protocol Api {

    func callApi<T: Decodable>(route: ApiRouter, decodeType type: T.Type) async throws -> T
}
