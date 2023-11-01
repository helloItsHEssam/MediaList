//
//  RalewayTests.swift
//  
//
//  Created by Hessam Mahdiabadi on 11/1/23.
//

import XCTest
@testable import MediaListFont

final class RalewayTests: XCTestCase {

    func testFontDescription() {
        // given
        let semiBoldFont = Raleway.semiBold
        
        // then
        let fontName = String(describing: semiBoldFont)
        
        // when
        XCTAssertEqual(fontName, "Raleway-SemiBold")
        XCTAssertNotEqual(fontName, "Raleway-ExtraBold")
        XCTAssertNotEqual(fontName, "Raleway-Regular")
    }

    func testSemiBoldFontSize() {
        // given
        let semiBoldFont = Raleway.semiBold
        
        // then
        let headlineSize = semiBoldFont.fontSize(basedOnTextStyle: .headline)
        let subheadline = semiBoldFont.fontSize(basedOnTextStyle: .subheadline)
        
        // when
        XCTAssertEqual(headlineSize, 22)
        XCTAssertNotEqual(headlineSize, subheadline)
    }
    
    func testExtraBoldFontSize() {
        // given
        let extraBoldFont = Raleway.extraBold
        
        // then
        let headlineSize = extraBoldFont.fontSize(basedOnTextStyle: .headline)
        let subheadline = extraBoldFont.fontSize(basedOnTextStyle: .subheadline)
        
        // when
        XCTAssertEqual(headlineSize, 24)
        XCTAssertNotEqual(headlineSize, subheadline)
    }
    
    func testRegularFontSize() {
        // given
        let regularFont = Raleway.regular
        
        // then
        let titleSize = regularFont.fontSize(basedOnTextStyle: .title)
        let title3Size = regularFont.fontSize(basedOnTextStyle: .title3)
        
        // when
        XCTAssertEqual(titleSize, 10)
        XCTAssertNotEqual(titleSize, title3Size)
        XCTAssertEqual(title3Size, 12)
    }
}
