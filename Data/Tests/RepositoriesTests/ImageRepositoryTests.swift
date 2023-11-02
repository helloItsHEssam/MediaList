//
//  ImageRepositoryTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
import Domain
@testable import Network
@testable import Local
@testable import Repositories

final class ImageRepositoryTests: XCTestCase {

    var repository: ImageRepository!
    
    override func tearDown() {
        repository = nil
        
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("25371" + ".png")
        try? FileManager.default.removeItem(atPath: fileURL.path)
    }
    
    func testSuccessFetchPreviewSizeFromServer() async {
        
        // given
        let api = ApiImpl()
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
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
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
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
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
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
    
    func testFailFetchImageFromLocal() async {
        
        // given
        let api = ApiImpl()
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25372221.jpg"
        
        do {
            // when
            let imageFromLocal = try await repository.fetchImageFromLocal(imageName: imageUrl)
            
            // then
            XCTAssertEqual(imageFromLocal.size.width, 800)

        } catch {
            // then
            XCTAssertNotNil(error as? LocalError)
        }
    }
    
    func testSaveImageToDisk() async {
        
        // given
        let api = ApiImpl()
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let image = try await repository.fetchImageFromServer(imageUrl: imageUrl)
            try await repository.saveImageToDisk(imageName: imageUrl, image: image)
            let imageFromLocal = try await repository.fetchImageFromLocal(imageName: imageUrl)
            
            // then
            XCTAssertEqual(imageFromLocal.size.width, 800)

        } catch {
            // then
            XCTAssertNil(error as? NetworkError)
        }
    }
    
    func testFetchPreviewSizeFromLocal() async {
        
        // given
        let api = ApiImpl()
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let image = try await repository.fetchImageFromServer(imageUrl: imageUrl)
            try await repository.saveImageToDisk(imageName: imageUrl, image: image)
            let size = try await repository.fetchImageSizeFromLocal(imageName: imageUrl)
            
            // then
            XCTAssertEqual(size.width, 800)
            XCTAssertEqual(size.height, 450)
            
        } catch {
            // then
            XCTAssertNil(error)
        }
    }
    
    func testFailFetchPreviewSizeFromLocal() async {
        
        // given
        let api = ApiImpl()
        let localStorage = LocalStorageImpl()
        repository = ImageRepositoryImpl(api: api, localStorage: localStorage)
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/3232332.jpg"
        
        do {
            // when
            let _ = try await repository.fetchImageSizeFromLocal(imageName: imageUrl)
            
            // then
            
        } catch {
            // then
            XCTAssertNotNil(error)
        }
    }
}
