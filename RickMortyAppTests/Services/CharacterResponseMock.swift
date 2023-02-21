//
//  CharacterResponseMock.swift
//  RickMortyAppTests
//
//  Created by Ricky Austin on 20/02/23.
//

import Foundation

struct CharacterResponseMock {
    static var successGetPage: String {
        "{\"info\":{\"count\":826,\"pages\":42,\"next\":\"https://rickandmortyapi.com/api/character/?page=3\",\"prev\":\"https://rickandmortyapi.com/api/character/?page=1\"},\"results\":[{\"id\":21,\"name\":\"Aqua Morty\",\"status\":\"unknown\",\"species\":\"Humanoid\",\"type\":\"Fish-Person\",\"gender\":\"Male\",\"origin\":{\"name\":\"unknown\",\"url\":\"\"},\"location\":{\"name\":\"Citadel of Ricks\",\"url\":\"https://rickandmortyapi.com/api/location/3\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/21.jpeg\",\"episode\":[\"https://rickandmortyapi.com/api/episode/10\",\"https://rickandmortyapi.com/api/episode/22\"],\"url\":\"https://rickandmortyapi.com/api/character/21\",\"created\":\"2017-11-04T22:39:48.055Z\"},{\"id\":22,\"name\":\"Aqua Rick\",\"status\":\"unknown\",\"species\":\"Humanoid\",\"type\":\"Fish-Person\",\"gender\":\"Male\",\"origin\":{\"name\":\"unknown\",\"url\":\"\"},\"location\":{\"name\":\"Citadel of Ricks\",\"url\":\"https://rickandmortyapi.com/api/location/3\"},\"image\":\"https://rickandamortyapi.com/api/character/avatar/22.jpeg\",\"episode\":[\"https://rickandmortyapi.com/api/episode/10\",\"https://rickandmortyapi.com/api/episode/22\",\"https://rickandmortyapi.com/api/episode/28\"],\"url\":\"https://rickandmortyapi.com/api/character/22\",\"created\":\"2017-11-04T22:41:07.171Z\"}]}"
    }
    
    static var successGetDetail: String {
        "{\"id\":2,\"name\":\"Morty Smith\",\"status\":\"Alive\",\"species\":\"Human\",\"type\":\"\",\"gender\":\"Male\",\"origin\":{\"name\":\"unknown\",\"url\":\"\"},\"location\":{\"name\":\"Citadel of Ricks\",\"url\":\"https://rickandmortyapi.com/api/location/3\"},\"image\":\"https://rickandmortyapi.com/api/character/avatar/2.jpeg\",\"episode\":[\"https://rickandmortyapi.com/api/episode/1\",\"https://rickandmortyapi.com/api/episode/2\"],\"url\":\"https://rickandmortyapi.com/api/character/2\",\"created\":\"2017-11-04T18:50:21.651Z\"}"
    }
    
    static var failFilterPage: String {
        "{\"error\":\"There is nothing here\"}"
    }
    
    static var failGetDetail: String {
        "{\"error\":\"Character not found\"}"
    }
}
