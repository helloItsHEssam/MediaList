//
//  PreviewMediaSizeMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Network
import Domain

struct PreviewMediaSizeMapper: Mapper {
    
    typealias Dto = PreviewMediaSizeDTO
    typealias Entity = PreviewMediaSize
    
    func mapDtoToEntity(input: PreviewMediaSizeDTO) -> PreviewMediaSize {
        return .init(width: input.width, height: input.height)
    }
    
    func mapEntityToDto(input: PreviewMediaSize) -> PreviewMediaSizeDTO {
        return .init(width: input.width, height: input.height)
    }
}

