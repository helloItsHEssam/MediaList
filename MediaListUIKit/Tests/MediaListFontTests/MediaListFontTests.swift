//
//  MediaListFontTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import XCTest
@testable import MediaListFont

final class MediaListFontTests: XCTestCase {

    override func tearDown() {
        MediaListFont.unRegisterFonts()
    }
    
    func testRalewayFontRegister() {
        // given
        let raleway = Raleway.regular
        
        // when then
        XCTAssertNoThrow(try MediaListFont.registerFont(fontName: raleway.description,
                                                        withExtension: raleway.fileExtension))
    }
    
    func testRalewayFontUnRegister() {
        // given
        let raleway = Raleway.regular
        
        // when then
        XCTAssertNoThrow(try MediaListFont.registerFont(fontName: raleway.description,
                                                        withExtension: raleway.fileExtension))
        XCTAssertNoThrow(try MediaListFont.unRegisterFont(fontName: raleway.description,
                                                        withExtension: raleway.fileExtension))
    }
    
    func testWrongRalewayFontUnRegister() {
        // given
        let raleway = Raleway.regular
        
        // when then
        XCTAssertThrowsError(try MediaListFont.unRegisterFont(fontName: raleway.description,
                                                        withExtension: raleway.fileExtension))
    }
    
    func testDuplicateFontRegister() {
        // given
        let raleway = Raleway.regular
        
        // when then
        XCTAssertNoThrow(try MediaListFont.registerFont(fontName: raleway.description,
                                                        withExtension: raleway.fileExtension))
        XCTAssertThrowsError(try MediaListFont.registerFont(fontName: raleway.description,
                                                        withExtension: raleway.fileExtension))        
    }
    
    func testFakeFontRegister() {
        
        // given
        let fontName = "fake"
        let fileExtension = "ttf"
        
        // when then
        XCTAssertThrowsError(try MediaListFont.registerFont(fontName: fontName,
                                                        withExtension: fileExtension))
    }
}
