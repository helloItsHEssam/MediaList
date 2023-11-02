//
//  MediaDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

struct MediaDTO: Decodable {
    
    public var title: String?
    public var previewLink: String?
    public var mediaLink: String?
    public var type: MediaTypeDTO?
}
