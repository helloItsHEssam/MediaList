//
//  MediaUseCaseTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/2/23.
//

import XCTest
import Combine
@testable import Domain

final class MediaUseCaseTests: XCTestCase {
    
    // MARK: - setup environment
    var cancellables: Set<AnyCancellable>!
    var useCase: MediaUseCase!
    var requestCancellable: AnyCancellable!
    
    override func setUp() {
        cancellables = []
    }
    
    override func tearDown() {
        useCase = nil
        cancellables.removeAll()
    }
    
    // MARK: Tests
    func testFailFetchMediaList() {
        
        // given
        let mediaRepository = MediaRepositoryErrorMock()
        let imageRepository = ImageRepositoryImageSizeFromServerMock()
        useCase = MediaUseCaseImpl(mediaRepository: mediaRepository, imageRepository: imageRepository)

        let expectation = XCTestExpectation(description: "fetch media list")

        var error: DomainError?

        // when
        useCase.fetchMediaList()
            .sink { completion in
                switch completion {
                case .failure(let domainError): error = domainError
                case .finished: break
                }
                expectation.fulfill()
            } receiveValue: { _ in }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)

        // then
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .cannotFetchMediaList)
    }
    
    func testSuccessFetchMediaList() {
        
        // given
        let mediaRepository = MediaRepositoryMock()
        let imageRepository = ImageRepositoryImageSizeFromServerMock()
        useCase = MediaUseCaseImpl(mediaRepository: mediaRepository, imageRepository: imageRepository)
        
        let expectation = XCTestExpectation(description: "fetch media list")
        
        var mediaList: [Media]?
        
        // when
        useCase.fetchMediaList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { values in
                mediaList = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNotNil(mediaList)
        XCTAssertEqual(mediaList?.count, 2)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.width, 100)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.orientation, .portrait)
    }
    
    func testSuccessFetchMediaListWithDefaultPreviewSize() {
        
        // given
        let mediaRepository = MediaRepositoryMock()
        let imageRepository = ImageRepositoryImageSizeFromServerErrorMock()
        useCase = MediaUseCaseImpl(mediaRepository: mediaRepository, imageRepository: imageRepository)
        
        let expectation = XCTestExpectation(description: "fetch media list")
        
        var mediaList: [Media]?
        
        // when
        useCase.fetchMediaList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { values in
                mediaList = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNotNil(mediaList)
        XCTAssertEqual(mediaList?.count, 2)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.width, 200)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.orientation, .landscape)
    }
    
    func testSuccessFetchMediaListAndFetchFromLocal() {
        
        // given
        let mediaRepository = MediaRepositoryMock()
        let imageRepository = ImageRepositoryImageSizeFromLocalMock()
        useCase = MediaUseCaseImpl(mediaRepository: mediaRepository, imageRepository: imageRepository)
        
        let expectation = XCTestExpectation(description: "fetch media list")
        
        var mediaList: [Media]?
        
        // when
        useCase.fetchMediaList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { values in
                mediaList = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNotNil(mediaList)
        XCTAssertEqual(mediaList?.count, 2)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.width, 150)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.orientation, .portrait)
    }
    
    func testSuccessFetchMediaListAndFetchFromLocalWithDefaultPreviewSize() {
        
        // given
        let mediaRepository = MediaRepositoryMock()
        let imageRepository = ImageRepositoryImageSizeFromLocalErrorMock()
        useCase = MediaUseCaseImpl(mediaRepository: mediaRepository, imageRepository: imageRepository)
        
        let expectation = XCTestExpectation(description: "fetch media list")
        
        var mediaList: [Media]?
        
        // when
        useCase.fetchMediaList()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            }, receiveValue: { values in
                mediaList = values
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 5.0)
        
        // then
        XCTAssertNotNil(mediaList)
        XCTAssertEqual(mediaList?.count, 2)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.width, 200)
        XCTAssertEqual(mediaList?.first?.previewMediaSize?.orientation, .landscape)
    }
}
