//
//  MediaRepositoryTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
import Domain
import Network
@testable import Repositories
@testable import Mock

final class MediaRepositoryTests: XCTestCase {

    var repository: MediaRepository!
    
    override func tearDown() {
        repository = nil
    }
    
    func testSuccessFetchMediaList() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [ResponseMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)
        repository = MediaRepositoryImpl(api: api)
        
        do {
            // when
            let mediaList = try await repository.fetchMediaList()
            
            // then
            XCTAssertEqual(mediaList.count, 2)
            XCTAssertEqual(mediaList.first?.title, "Text 1")
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testFailFetchMediaList() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [OfflineServerMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)
        repository = MediaRepositoryImpl(api: api)
        
        do {
            // when
            let _ = try await repository.fetchMediaList()
            
        } catch {
            
            // then
            XCTAssertNotNil(error)
        }
    }
}
