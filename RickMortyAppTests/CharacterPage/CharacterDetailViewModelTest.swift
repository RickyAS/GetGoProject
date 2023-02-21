//
//  CharacterDetailViewModelTest.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import XCTest
@testable import RickMortyApp

final class CharacterDetailViewModelTest: XCTestCase {
    var service: MainServiceMock!
    var viewModel: CharacterDetailViewModelProtocol!
    
    override func setUpWithError() throws {
        service = MainServiceMock()
    }

    override func tearDownWithError() throws {
        service = nil
        viewModel = nil
    }

    func testSuccessGetDetail() throws {
        service.jsonString = CharacterResponseMock.successGetDetail
        viewModel = CharacterDetailViewModelMock(service: service, id: 2)
        viewModel.getCharacter { errMsg in
            XCTAssertNil(errMsg)
        }
    }

    func testFailGetDetail() throws {
        service.jsonString = CharacterResponseMock.failGetDetail
        viewModel = CharacterDetailViewModelMock(service: service, id: 2)
        viewModel.getCharacter { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }
    
    func testFailGetDetailById() throws {
        service.jsonString = CharacterResponseMock.successGetDetail
        viewModel = CharacterDetailViewModelMock(service: service, id: 1)
        viewModel.getCharacter { errMsg in
            XCTAssertNotNil(errMsg)
        }
    }

}
