//
//  PreviewMediaSizeTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
@testable import Domain

final class PreviewMediaSizeTests: XCTestCase {

    func testMediaPortraitOrientation() {
        
        // given
        let size = PreviewMediaSize(width: 100, height: 200)
        
        // when
        let orientation = size.orientation
        
        // then
        XCTAssertEqual(orientation, .portrait)
    }
    
    func testMediaLandscapeOrientation() {
        
        // given
        let size = PreviewMediaSize(width: 200, height: 190)
        
        // when
        let orientation = size.orientation
        
        // then
        XCTAssertEqual(orientation, .landscape)
    }

}
