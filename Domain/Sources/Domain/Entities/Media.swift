//
//  Media.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import Foundation

public struct Media: Identifiable, CustomStringConvertible {
    
    public var id: String {
        previewLink ?? UUID().uuidString
    }

    public var title: String?
    public var type: MediaType?
    public var previewLink: String?
    public var mediaLink: String?
    public var previewMediaSize: PreviewMediaSize?
    
    init(title: String?, type: MediaType?,
         previewLink: String?, mediaLink: String?) {
        self.title = title
        self.type = type
        self.previewLink = previewLink
        self.mediaLink = mediaLink
    }
    
    public mutating func update(PreviewMediaSize mediaSize: PreviewMediaSize) {
        self.previewMediaSize = mediaSize
    }
    
    public var description: String {
        guard let type else {
            return "The received media type has an error."
        }
        
        guard let mediaLink else {
            return "The URL of the media has a problem."
        }
        
        guard URL(string: mediaLink) != nil else {
            return "The URL of the media has a problem."
        }
        
        var prefix: String
        switch type {
        case .image: prefix = "Display image"
        case .video: prefix = "Play video"
        }
        
        return prefix + " with \(mediaLink) URL"
    }
}
