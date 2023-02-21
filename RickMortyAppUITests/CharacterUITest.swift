//
//  CharacterUITest.swift
//  RickMortyAppUITests
//
//  Created by Ricky Austin on 21/02/23.
//

import XCTest

final class CharacterUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
    }
    
    func testScrollCollectionToSecondPage() throws {
        start()
        let firstCell =  app.collectionViews["mainCollection"].cells.firstMatch
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))
        let cell = app.collectionViews["mainCollection"].staticTexts["Aqua Morty"]
        while !cell.exists {
            app.swipeUp(velocity: .fast)
        }
        cell.tap()
    }
    
    func testSuccessFilterByButton() throws {
        start()
        app.navigationBars["Character"].buttons["nav filter"].tap()
        app.collectionViews["statusCol"].staticTexts["Dead"].tap()
        app.collectionViews["speciesCol"].staticTexts["Animal"].tap()
        app.collectionViews["genderCol"].staticTexts["Female"].tap()
        app.buttons["Apply"].tap()
        selectFirstCell()
    }
    
    func testFailFilterByButton() throws {
        start()
        app.navigationBars["Character"].buttons["nav filter"].tap()
        app.collectionViews["statusCol"].staticTexts["Unknown"].tap()
        app.collectionViews["speciesCol"].staticTexts["Animal"].tap()
        app.collectionViews["genderCol"].staticTexts["Female"].tap()
        app.buttons["Apply"].tap()
        checkAlertExist()
    }
    
    func testSuccessFilterBySearch() throws {
        start()
        app.navigationBars["Character"].searchFields.element.tap()
        let searchArr = Array("Aqua").map({String($0)})
        searchArr.forEach({
            app.keys[$0].tap()
        })
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        selectFirstCell()
    }
    
    func testFailFilterBySearch() throws {
        start()
        app.navigationBars["Character"].searchFields.element.tap()
        let searchArr = Array("Waterfall").map({String($0)})
        searchArr.forEach({
            app.keys[$0].tap()
        })
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards",".buttons[\"search\"]",".buttons[\"Search\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        checkAlertExist()
        
    }
    
    func testOpenDetail() {
        start()
        let cell = app.collectionViews["mainCollection"].cells.firstMatch
        let title = cell.staticTexts.firstMatch.label
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()
        XCTAssertTrue(app.navigationBars[title].waitForExistence(timeout: 5))
        app.swipeUp(velocity: .fast)
        app.swipeUp(velocity: .fast)
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
    }
    
    private func start() {
        app.launch()
        app.tabBars["Tab Bar"].buttons["Character"].tap()
    }
    
    private func selectFirstCell() {
        let cell = app.collectionViews["mainCollection"].cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
        cell.tap()
    }
    
    private func checkAlertExist() {
        let alert = app.alerts["There's a mistake"]
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        alert.buttons.element.tap()
    }
    
}
