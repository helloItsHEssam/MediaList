//
//  MediaDTO.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import Foundation

public struct MediaDTO: Decodable {
    
    public var title: String?
    public var previewLink: String?
    public var mediaLink: String?
    public var type: MediaTypeDTO?
    
    public init(title: String?, previewLink: String?,
                mediaLink: String?, type: MediaTypeDTO?) {
        self.title = title
        self.previewLink = previewLink
        self.mediaLink = mediaLink
        self.type = type
    }
}
