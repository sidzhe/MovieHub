//
//  SearchResultInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 19.02.2024.
//

import XCTest
@testable import MovieHub

final class SearchResultInteractorTest: XCTestCase {
    
    var sut: URLSession!
    var networkService: NetworkServiceProtocol!
    var interactor: SearchResultInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        networkService = MockNetworkService()
        interactor = SearchResultInteractor(networkService: networkService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        networkService = nil
        try super.tearDownWithError()
    }
    
    func testSearchPersonStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/person/search?query=Brad%20Pitt&limit=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchPerson.header
        var statusCode: Int? = nil
        var responseError: Error? = nil
        let promise = expectation(description: "Test search person")
        
        let dataTask = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 3.0)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testSearchPersonSuccess() {
        let personID = 25584
        let name = "Brad Pitt"
        interactor.requestPerson(name: name)
        XCTAssertEqual(interactor.searchPerson?.docs.first?.id, personID)
    }
    
    func testSearchByTitleStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie/search?query=Man&limit=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchPerson.header
        var statusCode: Int? = nil
        var responseError: Error? = nil
        let promise = expectation(description: "Test search person")
        
        let dataTask = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 3.0)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func  testSearchByTitleSuccess() {
        let movieID = 709570
        let movie = "Тест"
        interactor.requestSearch(movie)
        XCTAssertEqual(interactor.searchMovie?.docs.first?.id, movieID)
    }
}
