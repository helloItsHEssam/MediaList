//
//  LocalStorageTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
@testable import Network
@testable import Local

final class LocalStorageTests: XCTestCase {
 
    private var local: LocalStorage!

    override func tearDown() {
        local = nil
        
        let documentsDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("25371" + ".png")
        try? FileManager.default.removeItem(atPath: fileURL.path)
    }
    
    func testSaveImageToDisk() async {
        
        // given
        let api = ApiImpl()
        local = LocalStorageImpl()
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let imageData = try await api.fetchImageData(route: .fetchImage(imageUrl: imageUrl))
            let image = UIImage(data: imageData)
            
            // then
            try await local.saveImageToDisk(imageUrl: imageUrl, image: image!)
            XCTAssertEqual(image?.size.width, 800)

        } catch {
            // then
            XCTAssertNil(error as? LocalError)
        }
    }
    
    func testFailSaveImageToDisk() async {
        
        // given
        let api = ApiImpl()
        local = LocalStorageImpl()
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let imageData = try await api.fetchImageData(route: .fetchImage(imageUrl: imageUrl))
            let image = UIImage(data: imageData)
            
            // then
            try await local.saveImageToDisk(imageUrl: imageUrl, image: image!)
            try await local.saveImageToDisk(imageUrl: imageUrl, image: image!)
            
            XCTAssertEqual(image?.size.width, 800)

        } catch {
            // then
            XCTAssertNotNil(error as? LocalError)
            XCTAssertEqual(error as? LocalError, .cannotSaveImageIntoDiskBecauseOfImageAlreadyExists)
        }
    }
    
    func testFetchImage() async {
        
        // given
        let api = ApiImpl()
        local = LocalStorageImpl()
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let imageData = try await api.fetchImageData(route: .fetchImage(imageUrl: imageUrl))
            let image = UIImage(data: imageData)
            
            // then
            try await local.saveImageToDisk(imageUrl: imageUrl, image: image!)
            
            let imageFromDisk = try await local.fetchImage(imageUrl: imageUrl)
            
            XCTAssertEqual(imageFromDisk.size.width, 800)

        } catch {
            // then
            XCTAssertNil(error as? LocalError)
        }
    }
    
    func testFetchImageSize() async {
        
        // given
        let api = ApiImpl()
        local = LocalStorageImpl()
        let imageUrl = "https://wallpapershome.com/images/pages/ico_h/25371.jpg"
        
        do {
            // when
            let imageData = try await api.fetchImageData(route: .fetchImage(imageUrl: imageUrl))
            let image = UIImage(data: imageData)
            
            // then
            try await local.saveImageToDisk(imageUrl: imageUrl, image: image!)
            
            let size = try await local.fetchImageSize(imageUrl: imageUrl)
            
            XCTAssertEqual(size.width, 800)

        } catch {
            // then
            XCTAssertNil(error as? LocalError)
        }
    }
}
