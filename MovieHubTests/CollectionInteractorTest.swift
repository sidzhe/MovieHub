//
//  CollectionInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 18.02.2024.
//

import XCTest
@testable import MovieHub

final class CollectionInteractorTest: XCTestCase {
    
    var sut: URLSession!
    var interactor: CollectionInteractor!
    var networkService: NetworkServiceProtocol!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        networkService = MockNetworkService()
        interactor = CollectionInteractor(networkService: networkService, slug: "100_greatest_movies_XXI")
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        networkService = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testGetCollectionStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&lists=100_greatest_movies_XXI"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchDetailById.header
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
    
    func testGetCollectionSuccess() {
        let movie = "1+1"
        interactor.getCollection()
        XCTAssertEqual(interactor.collectionData?.docs.first?.name, movie)
    }
}
