//
//  MediaTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
@testable import Domain

final class MediaTests: XCTestCase {

    func testNotDetectMediaType() {
        
        // given
        let media = Media(title: "Title 1",
                          type: nil, previewLink: nil, mediaLink: nil)
        
        // when
        let desc = String(describing: media)
        
        // then
        XCTAssertEqual(desc, "The received media type has an error.")
    }
    
    func testNilMediaLink() {
        
        // given
        let media = Media(title: "Title 1", type: .image,
                          previewLink: nil, mediaLink: nil)
        
        // when
        let desc = String(describing: media)
        
        // then
        XCTAssertEqual(desc, "The URL of the media has a problem.")
    }
    
    func testWrongMediaLink() {
        
        // given
        let media = Media(title: "Title 1", type: .image,
                          previewLink: nil, mediaLink: "")
        
        // when
        let desc = String(describing: media)
        
        // then
        XCTAssertEqual(desc, "The URL of the media has a problem.")
    }
    
    func testImageMediaLink() {
        
        // given
        let mediaLink = "1.jpg"
        let media = Media(title: "Title 1", type: .image,
                          previewLink: nil, mediaLink: mediaLink)
        
        // when
        let desc = String(describing: media)
        
        // then
        XCTAssertEqual(desc, "Display image with \(mediaLink) URL")
    }
    
    func testVideoMediaLink() {
        
        // given
        let mediaLink = "1.mp4"
        let media = Media(title: "Title 1", type: .video,
                          previewLink: nil, mediaLink: mediaLink)
        
        // when
        let desc = String(describing: media)
        
        // then
        XCTAssertEqual(desc, "Play video with \(mediaLink) URL")
    }

}
