//
//  MediaMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Domain
import Network

struct MediaMapper: Mapper {
    
    typealias Dto = MediaDTO
    typealias Entity = Media
    
    private var mediaTypeMapper: MediaTypeMapper
    
    init() {
        self.mediaTypeMapper = .init()
    }

    func mapDtoToEntity(input: MediaDTO) -> Media {
        let type = mediaTypeMapper.mapDtoToEntity(input: input.type)
        return .init(title: input.title, type: type,
                     previewLink: input.previewLink, mediaLink: input.mediaLink)
    }
    
    func mapEntityToDto(input: Media) -> MediaDTO {
        let type = mediaTypeMapper.mapEntityToDto(input: input.type)
        return .init(title: input.title, previewLink: input.previewLink,
                     mediaLink: input.mediaLink, type: type)
    }
}
