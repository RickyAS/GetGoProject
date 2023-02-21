//
//  CharacterViewModelTest.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import XCTest
@testable import RickMortyApp

final class CharacterViewModelTest: XCTestCase {
    var mainService: MainServiceMock!
    var viewModel: CharacterViewModelProtocol!
    
    override func setUpWithError() throws {
        mainService = MainServiceMock()
    }

    override func tearDownWithError() throws {
        mainService = nil
        viewModel = nil
    }

    func testSuccessGetPage() throws {
        mainService.jsonString = CharacterResponseMock.successGetPage
        viewModel = CharacterViewModelMock(service: mainService)
        viewModel.getCharacters(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPage() throws {
        mainService.jsonString = CharacterResponseMock.failFilterPage
        viewModel = CharacterViewModelMock(service: mainService)
        viewModel.getCharacters(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
    
    func testSuccessGetPageBySearch() throws {
        mainService.jsonString = CharacterResponseMock.successGetPage
        viewModel = CharacterViewModelMock(service: mainService)
        viewModel.searchText = "aqua"
        viewModel.getCharacters(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPageBySearch() throws {
        mainService.jsonString = CharacterResponseMock.successGetPage
        viewModel = CharacterViewModelMock(service: mainService)
        viewModel.searchText = "water"
        viewModel.getCharacters(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
    
    func testSuccessGetPageByFilter() throws {
        mainService.jsonString = CharacterResponseMock.successGetPage
        viewModel = CharacterViewModelMock(service: mainService)
        viewModel.charFilter = CharacterFilterModel(status: "unknown", species: "", gender: "")
        viewModel.getCharacters(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPageByFilter() throws {
        mainService.jsonString = CharacterResponseMock.successGetPage
        viewModel = CharacterViewModelMock(service: mainService)
        viewModel.charFilter = CharacterFilterModel(status: "alive", species: "", gender: "")
        viewModel.getCharacters(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
}
