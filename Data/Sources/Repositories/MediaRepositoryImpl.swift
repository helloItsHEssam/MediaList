//
//  MediaRepositoryImpl.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Domain
import Network

public class MediaRepositoryImpl: MediaRepository {
    
    private var api: Api
    private var mapper: MediaMapper
    
    public init(api: Api) {
        self.api = api
        self.mapper = .init()
    }
    
    public func fetchMediaList() async throws -> [Domain.Media] {
        let mediaDtoList = try await api.callApi(route: .mediaList, decodeType: [MediaDTO].self)
        
        let mediaList = mapper.mapDtosToEntities(input: mediaDtoList)
        return mediaList
    }
}
