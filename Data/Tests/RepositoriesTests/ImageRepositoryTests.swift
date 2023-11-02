//
//  ImageRepositoryTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
import Domain
@testable import Network
@testable import Repositories

final class ImageRepositoryTests: XCTestCase {

    var repository: ImageRepository!
    
    override func tearDown() {
        repository = nil
    }
    
    func testSuccessFetchPreviewSizeFromServer() async {
        
        // given
        let api = ApiImpl()
        repository = ImageRepositoryImpl(api: api)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let size = try await repository.fetchImageSizeFromServer(imageUrl: imageUrl)
            
            // then
            XCTAssertEqual(size.width, 800)
            XCTAssertEqual(size.height, 450)
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testFailFetchPreviewSizeFromServer() async {
        
        // given
        let api = ApiImpl()
        repository = ImageRepositoryImpl(api: api)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25332371.jpg"
        
        do {
            // when
            let _ = try await repository.fetchImageSizeFromServer(imageUrl: imageUrl)
            
        } catch {
            // then
            XCTAssertNotNil(error)
        }
    }
    
    func testFetchImage() async {
        
        // given
        let api = ApiImpl()
        repository = ImageRepositoryImpl(api: api)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let image = try await repository.fetchImageFromServer(imageUrl: imageUrl)
            
            // then
            XCTAssertEqual(image.size.width, 800)

        } catch {
            // then
            XCTAssertNil(error as? NetworkError)
        }
    }
}
