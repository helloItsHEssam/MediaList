//
//  PreviewMediaSizeMapper.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation
import Domain

public struct PreviewMediaSizeMapper: Mapper {
    
    public typealias Dto = PreviewMediaSizeDTO
    public typealias Entity = PreviewMediaSize
    
    public init() {}
    
    public func mapDtoToEntity(input: PreviewMediaSizeDTO) -> PreviewMediaSize {
        return .init(width: input.width, height: input.height)
    }
    
    public func mapEntityToDto(input: PreviewMediaSize) -> PreviewMediaSizeDTO {
        return .init(width: input.width, height: input.height)
    }
}

