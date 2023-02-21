//
//  EpisodeViewModelTest.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import XCTest
@testable import RickMortyApp

final class EpisodeViewModelTest: XCTestCase {
    var mainService: MainServiceMock!
    var viewModel: EpisodeViewModelProtocol!
    
    override func setUpWithError() throws {
        mainService = MainServiceMock()
    }

    override func tearDownWithError() throws {
        mainService = nil
        viewModel = nil
    }

    func testSuccessGetPage() throws {
        mainService.jsonString = EpisodeResponseMock.successGetPage
        viewModel = EpisodeViewModelMock(service: mainService)
        viewModel.getEpisodes(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPage() throws {
        mainService.jsonString = EpisodeResponseMock.failFilterPage
        viewModel = EpisodeViewModelMock(service: mainService)
        viewModel.getEpisodes(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
    
    func testSuccessGetPageBySearch() throws {
        mainService.jsonString = EpisodeResponseMock.successGetPage
        viewModel = EpisodeViewModelMock(service: mainService)
        viewModel.searchText = "pilot"
        viewModel.getEpisodes(isReload: true) { errMsg in
            XCTAssertNil(errMsg)
        }
    }
    
    func testFailGetPageBySearch() throws {
        mainService.jsonString = EpisodeResponseMock.successGetPage
        viewModel = EpisodeViewModelMock(service: mainService)
        viewModel.searchText = "wingman"
        viewModel.getEpisodes(isReload: true) { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
}
