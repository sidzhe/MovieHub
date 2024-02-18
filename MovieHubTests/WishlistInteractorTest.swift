//
//  WishlistInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 18.02.2024.
//

import XCTest
@testable import MovieHub

final class WishlistInteractorTest: XCTestCase {
    
    var networkService: NetworkServiceProtocol!
    var storageService: StorageServiceProtocol!
    var interactor: WishlistInteractor!
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        networkService = MockNetworkService()
        storageService = StubStorageService()
        interactor = WishlistInteractor(networkService: networkService, storageService: storageService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        networkService = nil
        storageService = nil
        try super.tearDownWithError()
    }
    
    func testRequestWish() {
        let movie = "Форсаж"
        interactor.requestWish(["666"])
        XCTAssertEqual(interactor.favoriteModel?.first?.name, movie)
    }
    
    func testRequestWishStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&id=666"
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
    
    func testUpdateFavoriteModelSuccese() {
        let movieID = 666
        interactor.updateWishModel()
        XCTAssertEqual(interactor.favoriteModel?.first?.id, movieID)
    }
    
    func testUpdateFavoriteModelFailure() {
        let movieID: Int? = nil
        interactor.updateWishModel()
        interactor.favoriteModel = nil
        XCTAssertEqual(interactor.favoriteModel?.first?.id, movieID)
    }
}
