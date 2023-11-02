//
//  ApiRouterTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
@testable import Network

final class ApiRouterTests: XCTestCase {

    func testGetHttpMethod() {
        // given
        let route = ApiRouter.mediaList
        
        // when
        let httpMethod = route.getHttpMethod()
        
        // then
        XCTAssertEqual(httpMethod, .get)
        XCTAssertNotEqual(httpMethod, .post)
    }
    
    func testPath() {
        // given
        let route = ApiRouter.mediaList
        
        // when
        let path = route.urlPath
        
        // then
        XCTAssertEqual(path, "/medialist")
    }
    
    func testCreateURL() {
        // given
        let route = ApiRouter.mediaList
        
        // when
        let url = route.createURL()
        
        // then
        XCTAssertEqual(url.absoluteString, "https://c62881db-c803-4c5e-907e-3b1d843fa7fd.mock.pstmn.io/medialist")
    }
    
    func testCreateImageURL() {
        // given
        let route = ApiRouter.fetchImage(imageUrl: "https://wallpapershome.com/images/pages/ico_h/25371.jpg")
        
        // when
        let url = route.createURL()
        
        // then
        XCTAssertEqual(url.absoluteString, "https://wallpapershome.com/images/pages/ico_h/25371.jpg")
    }
}
