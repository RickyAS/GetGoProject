//
//  LocationResponseMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation

struct LocationResponseMock {
    static var successGetPage: String {
        "{\"info\":{\"count\":126,\"pages\":7,\"next\":\"https://rickandmortyapi.com/api/location?page=3\",\"prev\":\"https://rickandmortyapi.com/api/location?page=1\"},\"results\":[{\"id\":21,\"name\":\"Testicle Monster Dimension\",\"type\":\"Dimension\",\"dimension\":\"Testicle Monster Dimension\",\"residents\":[\"https://rickandmortyapi.com/api/character/7\",\"https://rickandmortyapi.com/api/character/436\"],\"url\":\"https://rickandmortyapi.com/api/location/21\",\"created\":\"2017-11-18T19:41:01.605Z\"},{\"id\":22,\"name\":\"Signus 5 Expanse\",\"type\":\"unknown\",\"dimension\":\"Cromulon Dimension\",\"residents\":[\"https://rickandmortyapi.com/api/character/24\",\"https://rickandmortyapi.com/api/character/309\"],\"url\":\"https://rickandmortyapi.com/api/location/22\",\"created\":\"2017-11-18T20:27:26.218Z\"}]}"
    }
    
    static var successGetDetail: String {
        "{\"id\":2,\"name\":\"Abadango\",\"type\":\"Cluster\",\"dimension\":\"unknown\",\"residents\":[\"https://rickandmortyapi.com/api/character/6\"],\"url\":\"https://rickandmortyapi.com/api/location/2\",\"created\":\"2017-11-10T13:06:38.182Z\"}"
    }
    
    static var failFilterPage: String {
        "{\"error\":\"There is nothing here\"}"
    }
    
    static var failGetDetail: String {
        "{\"error\":\"Location not found\"}"
    }
}
