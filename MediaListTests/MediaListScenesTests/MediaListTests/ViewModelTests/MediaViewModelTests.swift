//
//  MediaViewModelTests.swift
//  MediaListTests
//
//  Created by Hessam Mahdiabadi on 11/3/23.
//

import XCTest
import Combine
@testable import MediaList

final class MediaViewModelTests: XCTestCase {

    var cancellables: Set<AnyCancellable>!
    var viewModel: MediaViewModel!
    
    override func setUp() {
        cancellables = []
        viewModel = ViewModelFactory.shared.createMediaViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
    }

    func testViewState() {

        // given
        let expectation = XCTestExpectation(description: "change view state")
        var newState: ViewState?
        
        // when
        viewModel.fetchMediaList()
        
        viewModel.$viewState
            .first()
            .sink { state in
                newState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        // then
        XCTAssertNotNil(newState)
        XCTAssertEqual(newState, .loading)
    }
    
    func testFetchMediaList() {
        
        // given
        let expectation = XCTestExpectation(description: "change view state")
        var newState: ViewState?
        
        // when
        viewModel.fetchMediaList()
        
        viewModel.$viewState
            .first()
            .sink { state in
                newState = state
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        
        // then
        if newState == .result {
            XCTAssertEqual(viewModel.mediaList.count, 9)
            
        } else {
            XCTAssertEqual(viewModel.mediaList.count, 0)
        }
    }
}
