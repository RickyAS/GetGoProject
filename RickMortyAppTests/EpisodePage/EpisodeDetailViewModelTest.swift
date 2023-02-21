//
//  EpisodeDetailViewModelTest.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import XCTest
@testable import RickMortyApp

final class EpisodeDetailViewModelTest: XCTestCase {
    var service: MainServiceMock!
    var viewModel: EpisodeDetailViewModelProtocol!
    
    override func setUpWithError() throws {
        service = MainServiceMock()
    }

    override func tearDownWithError() throws {
        service = nil
        viewModel = nil
    }

    func testSuccessGetDetail() throws {
        service.jsonString = EpisodeResponseMock.successGetDetail
        viewModel = EpisodeDetailViewModelMock(service: service, id: 2)
        viewModel.getEpisode { errMsg in
            XCTAssertNil(errMsg)
        }
    }

    func testFailGetDetail() throws {
        service.jsonString = EpisodeResponseMock.failGetDetail
        viewModel = EpisodeDetailViewModelMock(service: service, id: 2)
        viewModel.getEpisode { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
    
    func testFailGetDetailById() throws {
        service.jsonString = EpisodeResponseMock.successGetDetail
        viewModel = EpisodeDetailViewModelMock(service: service, id: 1)
        viewModel.getEpisode { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
}
