//
//  LocationViewModelTest.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import XCTest
@testable import RickMortyApp

final class LocationViewModelTest: XCTestCase {
    var mainService: MainServiceMock!
    var viewModel: LocationViewModelProtocol!
    
    override func setUpWithError() throws {
        mainService = MainServiceMock()
    }

    override func tearDownWithError() throws {
        mainService = nil
        viewModel = nil
    }

    func testSuccessGetPage() throws {
        mainService.jsonString = LocationResponseMock.successGetPage
        viewModel = LocationViewModelMock(service: mainService)
        viewModel.getLocations(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPage() throws {
        mainService.jsonString = LocationResponseMock.failFilterPage
        viewModel = LocationViewModelMock(service: mainService)
        viewModel.getLocations(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
    
    func testSuccessGetPageBySearch() throws {
        mainService.jsonString = LocationResponseMock.successGetPage
        viewModel = LocationViewModelMock(service: mainService)
        viewModel.searchText = "test"
        viewModel.getLocations(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPageBySearch() throws {
        mainService.jsonString = LocationResponseMock.successGetPage
        viewModel = LocationViewModelMock(service: mainService)
        viewModel.searchText = "tenta"
        viewModel.getLocations(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
}
