//
//  MovieListInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 18.02.2024.
//

import XCTest
@testable import MovieHub

final class MovieListInteractorTest: XCTestCase {
    
    var networkService: NetworkServiceProtocol!
    var interactor: MovieListInteractor!
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = MockNetworkService()
        interactor = MovieListInteractor(networkService: networkService)
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        networkService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testRequestMoviesStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&rating.kp=4.5-10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchTitle.header
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error? = nil
        var statusCode: Int? = nil
        
        let dataTask = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 3)
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testRequestMoviesSuccese() {
        let movieName = "1+1"
        interactor.requestMovies(genre: .all)
        XCTAssertEqual(interactor.moviesData?.docs?.first?.name, movieName)
    }
}
