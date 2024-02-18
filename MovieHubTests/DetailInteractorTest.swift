//
//  DetailInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 18.02.2024.
//

import XCTest
@testable import MovieHub

final class DetailInteractorTest: XCTestCase {
    
    var sut: URLSession!
    var networkService: NetworkServiceProtocol!
    var storageService: StorageServiceProtocol!
    var interactor: DetailInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        networkService = MockNetworkService()
        storageService = StubStorageService()
        interactor = DetailInteractor(networkService: networkService, storageService: storageService, detailID: "666")
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        networkService = nil
        storageService = nil
        try super.tearDownWithError()
    }
    
    func testSearchDetailIDStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie/535341?limit=10"
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
    
    func testSearchDetailIDSuccess() {
        let movieID = "Форсаж"
        interactor.detailRequest()
        XCTAssertEqual(interactor.detailData?.name, movieID)
    }
}
