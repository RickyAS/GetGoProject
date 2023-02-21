//
//  LocationUITest.swift
//  RickMortyAppUITests
//
//  Created by Ricky Austin on 21/02/23.
//

import XCTest

final class LocationUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testScrollTableToSecondPage() throws {
        start()
        let firstCell =  app.tables["mainTable"].cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        let cell = app.tables["mainTable"].staticTexts["Pluto"]
        while !cell.exists {
            app.swipeUp(velocity: .fast)
        }
        cell.tap()
    }
    
    func testSuccessFilterBySearch() throws {
        start()
        app.navigationBars["Location"].searchFields.element.tap()
        let searchArr = Array("Pluto").map({String($0)})
        searchArr.forEach({
            app.keys[$0].tap()
        })
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let cell = app.tables["mainTable"].cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()
    }
    
    func testFailFilterBySearch() throws {
        start()
        app.navigationBars["Location"].searchFields.element.tap()
        let searchArr = Array("Plato").map({String($0)})
        searchArr.forEach({
            app.keys[$0].tap()
        })
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        checkAlertExist()
        
    }
    
    func testOpenDetail() {
        start()
        let cell = app.tables["mainTable"].cells.firstMatch
        let title = cell.staticTexts.firstMatch.label
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 5))
        app.swipeUp(velocity: .fast)
        app.swipeUp(velocity: .fast)
        app.navigationBars[title].swipeDown()
    }
    
    private func start() {
        app.launch()
        app.tabBars["Tab Bar"].buttons["Location"].tap()
    }
    
    private func checkAlertExist() {
        let alert = app.alerts["There's a mistake"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        alert.buttons.element.tap()
    }
}
