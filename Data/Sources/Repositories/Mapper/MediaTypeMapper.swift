//
//  MediaTypeMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Network
import Domain
import Common

struct MediaTypeMapper: Mapper {
    
    typealias Dto = MediaTypeDTO?
    typealias Entity = MediaType?
    
    func mapDtoToEntity(input: MediaTypeDTO?) -> MediaType? {
        guard let input else { return nil }
        return input == .image ? .image : .video
    }
    
    func mapEntityToDto(input: MediaType?) -> MediaTypeDTO? {
        guard let input else { return nil }
        return input == .image ? .image : .video
    }
}
