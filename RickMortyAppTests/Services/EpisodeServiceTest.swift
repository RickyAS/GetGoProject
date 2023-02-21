//
//  EpisodeServiceTest.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import XCTest
@testable import RickMortyApp

final class EpisodeServiceTest: XCTestCase {
    var mainService: MainServiceMock!
    
    override func setUpWithError() throws {
        mainService = MainServiceMock()
    }
    
    override func tearDownWithError() throws {
        mainService = nil
    }
    
    func testSuccessGetPage() throws {
        mainService.jsonString = EpisodeResponseMock.successGetPage
        mainService.getEpisodeList(page: 1, name: "") { result in
            if case .success(let response) = result {
                XCTAssertTrue(!response.results.isEmpty)
                return
            }
            XCTFail()
        }
    }
    
    func testFailGetPage() throws {
        mainService.jsonString = EpisodeResponseMock.failFilterPage
        mainService.getEpisodeList(page: 1, name: "") { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .decodingError)
                return
            }
            XCTFail()
        }
    }
    
    func testSuccessGetDetail() throws {
        mainService.jsonString = EpisodeResponseMock.successGetDetail
        mainService.getEpisodeDetail(id: 1) { result in
            if case .success(let model) = result {
                XCTAssertTrue(!model.name.isEmpty)
                return
            }
            XCTFail()
        }
    }
    
    func testFailGetDetail() throws {
        mainService.jsonString = EpisodeResponseMock.failGetDetail
        mainService.getEpisodeDetail(id: 1) { result in
            if case .failure(let error) = result {
                XCTAssertTrue(error == .decodingError)
                return
            }
            XCTFail()
        }
    }
}
