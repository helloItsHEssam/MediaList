//
//  ApiTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
import Alamofire
@testable import Network
@testable import Mock

final class ApiTests: XCTestCase {
 
    private var api: Api!

    override func tearDown() {
        api = nil
    }

    func testRealMediaListApiCall() async {
        
        // given
        api = ApiImpl()
        do {
            
            // when
            let mediaList = try await api.callApi(route: .mediaList, decodeType: [MediaDTO].self)
            
            // then
            XCTAssertEqual(mediaList.count, 9)
            XCTAssertEqual(mediaList.first?.title, "Text 1")

        } catch {
            // then
            XCTAssertNil(error as? NetworkError)
        }
    }
    
    func testOfflineApiCall() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [OfflineServerMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)
        
        do {
            // when
            let _ = try await api.callApi(route: .mediaList, decodeType: [MediaDTO].self)

        } catch {
            
            // then
            let networkError = error as? NetworkError
            XCTAssertNotNil(networkError)
            XCTAssertEqual(networkError, .cannotConnectToServer)
        }
    }
    
    func testBadResponseApiCall() async {
        
        // given
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [BadResponseMockURLProtocol.self]
        let api = ApiImpl(configuration: configuration)
        
        do {
            
            // when
            let _ = try await api.callApi(route: .mediaList, decodeType: [MediaDTO].self)

        } catch {
            
            // then
            let networkError = error as? NetworkError
            XCTAssertNotNil(networkError)
            XCTAssertEqual(networkError, .cannotParseJson)
        }
    }
    
    func testRealFetchImage() async {
        
        // given
        api = ApiImpl()
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        do {
            // when
            let image = try await api.fetchImage(route: .fetchImage(imageUrl: imageUrl))
            
            // then
            XCTAssertEqual(image.size.width, 800)

        } catch {
            // then
            XCTAssertNil(error as? NetworkError)
        }
    }
    
    func testBadURLForFetchImage() async {
        
        // given
        api = ApiImpl()
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/253232371.jpg"
        do {
            // when
            let image = try await api.fetchImage(route: .fetchImage(imageUrl: imageUrl))
            
            // then
            XCTAssertNotEqual(image.size.width, 800)

        } catch {
            // then
            XCTAssertNotNil(error as? NetworkError)
        }
    }
}
