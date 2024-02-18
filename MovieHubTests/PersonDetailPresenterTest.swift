//
//  PersonDetailPresenterTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 18.02.2024.
//

import XCTest
@testable import MovieHub

final class PersonDetailPresenterTest: XCTestCase {
    
    var presenter: PersonDetailPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = PersonDetailPresenter()
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        try super.tearDownWithError()
    }
    
    func testFormatAgeVer1() {
        let agesWithYearsInt = [
            5, 6, 7, 8, 9, 10,
            15, 16, 17, 18, 19, 20,
            25, 26, 27, 28, 29, 30,
            35, 36, 37, 38, 39, 40,
            45, 46, 47, 48, 49, 50,
            55, 56, 57, 58, 59, 60,
            65, 66, 67, 68, 69, 70,
            75, 76, 77, 78, 79, 80,
            85, 86, 87, 88, 89, 90,
            95, 96, 97, 98, 99, 100
        ]
        
        agesWithYearsInt.forEach { ear in
            let rightValue = ear.description + " " + Constant.age3
            let resultYear = presenter.formatAgeString(age: ear)
            XCTAssertEqual(resultYear, rightValue)
        }
    }
    
    func testFormatAgeVer2() {
        let agesWithYearsInt = [
            1, 21, 31, 41, 51, 61, 71, 81, 91, 101
        ]
        
        agesWithYearsInt.forEach { ear in
            let rightValue = ear.description + " " + Constant.age
            let resultYear = presenter.formatAgeString(age: ear)
            XCTAssertEqual(resultYear, rightValue)
        }
    }
    
    func testFormatAgeVer3() {
        let agesWithYearsInt = [
            2, 3, 4, 22, 23, 24,
            32, 33, 34, 42, 43,
            44, 52, 53, 54, 62,
            63, 64, 72, 73, 74,
            82, 83, 84, 92, 93, 94
        ]
        
        agesWithYearsInt.forEach { ear in
            let rightValue = ear.description + " " + Constant.age2
            let resultYear = presenter.formatAgeString(age: ear)
            XCTAssertEqual(resultYear, rightValue)
        }
    }
    
    func testRemoveHTMLSymbols() {
        let testText = "some test text"
        let inputText = "<a href=\"/name/1762646/\" class=\"all\">some test text</a>"
        let result = presenter.removingHTMLEscapes(text: inputText)
        XCTAssertEqual(result, testText)
    }
    
    func testDateFormatterAssert() {
        let inputDate = "1963-12-18T00:00:00.000Z"
        let outputDate = " • 18 декабря 1963"
        let result = presenter.dateFormatter(inputDate)
        XCTAssertEqual(result, outputDate)
    }
    
    func testConvertMajor() {
        let model = [MovieHub.BirthPlace(value: Optional("Актер"))]
        let output = "• Актер"
        let result = presenter.convertModel(model: model)
        XCTAssertEqual(result, output)
    }
}

