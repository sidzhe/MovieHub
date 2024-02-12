//
//  MainInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 12.02.2024.
//

import XCTest
@testable import MovieHub

final class MainInteractorTest: XCTestCase {
    
    var interactor: MainInteractorInputProtocol!
    var networkService: NetworkServiceProtocol!
    var storageService: StubStorageService!
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkService = MockNetworkService()
        storageService = StubStorageService()
        interactor = MainInteractor(networkService: networkService, storageService: storageService)
        sut = URLSession(configuration: .default)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        networkService = nil
        storageService = nil
        try super.tearDownWithError()
    }
    
    func testUserInfoFail() {
        storageService.currentUserResult = .failure(TestError.storageError)
        let result = interactor.getUserInfo()
        
        switch result {
            
        case .success(_):
            XCTFail("Expected failure, but got success.")
        case .failure(let error):
            XCTAssertEqual(error as? TestError, TestError.storageError)
        }
    }
    
    func testUserInfoCompleted() {
        let currentUser = UserEntity()
        storageService.currentUserResult = .success(currentUser)
        
        let result = interactor.getUserInfo()
        
        switch result {
            
        case .success(let user):
            XCTAssertEqual(user, currentUser)
        case .failure(_):
            XCTFail("Expected success, but got failure.")
        }
    }
    
    func testMostRatingWithGenreStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&rating.kp=4.5-10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.movieFilter.header
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
    
    func testRatingApiCallCompletes() {
        let movieID = 535341
        interactor.requestMostRating(genre: .all)
        XCTAssertEqual(interactor.mostPopular?.docs?.first?.id, movieID)
    }
    
    func testSearchByTitleStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie/search?query=Test&limit=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchTitle.header
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
    
    func testSearchByTitleApiCallCompletes() {
        let movieID = 709570
        interactor.requestSearch("Test")
        XCTAssertEqual(interactor.searchData?.docs.first?.id, movieID)
    }
    
    func testCollectionStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/list?pages=2&limit=10"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = MovieEndpoints.searchTitle.header
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
    
    func testCollectionsApiCallCompletes() {
        interactor.requestCollection()
        XCTAssertNotNil(interactor.collectionData)
    }
}


