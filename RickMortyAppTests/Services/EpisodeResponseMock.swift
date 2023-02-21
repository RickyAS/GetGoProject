//
//  EpisodeResponseMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation

struct EpisodeResponseMock {
    static var successGetPage: String {
        "{\"info\":{\"count\":51,\"pages\":3,\"next\":\"https://rickandmortyapi.com/api/episode?page=2\",\"prev\":null},\"results\":[{\"id\":1,\"name\":\"Pilot\",\"air_date\":\"December 2, 2013\",\"episode\":\"S01E01\",\"characters\":[\"https://rickandmortyapi.com/api/character/1\",\"https://rickandmortyapi.com/api/character/2\"],\"url\":\"https://rickandmortyapi.com/api/episode/1\",\"created\":\"2017-11-10T12:56:33.798Z\"},{\"id\":2,\"name\":\"Lawnmower Dog\",\"air_date\":\"December 9, 2013\",\"episode\":\"S01E02\",\"characters\":[\"https://rickandmortyapi.com/api/character/1\",\"https://rickandmortyapi.com/api/character/2\"],\"url\":\"https://rickandmortyapi.com/api/episode/2\",\"created\":\"2017-11-10T12:56:33.916Z\"}]}"
    }
    
    static var successGetDetail: String {
        "{\"id\":2,\"name\":\"Lawnmower Dog\",\"air_date\":\"December 9, 2013\",\"episode\":\"S01E02\",\"characters\":[\"https://rickandmortyapi.com/api/character/1\",\"https://rickandmortyapi.com/api/character/2\"],\"url\":\"https://rickandmortyapi.com/api/episode/2\",\"created\":\"2017-11-10T12:56:33.916Z\"}"
    }
    
    static var failFilterPage: String {
        "{\"error\":\"There is nothing here\"}"
    }
    
    static var failGetDetail: String {
        "{\"error\":\"Episode not found\"}"
    }
}
