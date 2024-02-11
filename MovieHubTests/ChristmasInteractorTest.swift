//
//  ChristmasInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 10.02.2024.
//

import XCTest
@testable import MovieHub

final class ChristmasInteractorTest: XCTestCase {
    
    var interactor: ChristmasInteractorInputProtocol!
    var mockNetworkService: NetworkServiceProtocol!
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        interactor = ChristmasInteractor(networkService: mockNetworkService)
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        mockNetworkService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie/95194?limit=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchDetailById.header
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error? = nil
        var statusCode: Int? = nil
        
        let dataTast = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTast.resume()
        wait(for: [promise], timeout: 3)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testApiCallCompletes() throws {
        let moviesID = 666
        interactor.getMovieWithId()
        XCTAssertEqual(interactor.loadedMovie?.id, moviesID)
    }
}
