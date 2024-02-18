//
//  PersonDetailInteractorTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 18.02.2024.
//

import XCTest
@testable import MovieHub

final class PersonDetailInteractorTest: XCTestCase {
    
    var sut: URLSession!
    var networkService: NetworkServiceProtocol!
    var interactor: PersonDetailInteractor!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
        networkService = MockNetworkService()
        interactor = PersonDetailInteractor(networkService: networkService, personId: 666)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        interactor = nil
        networkService = nil
        try super.tearDownWithError()
    }
    
    func testPersonRequestStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/person?page=1&limit=10&selectFields=name&selectFields=enName&selectFields=photo&selectFields=growth&selectFields=birthday&selectFields=age&selectFields=birthPlace&selectFields=spouses&selectFields=profession&selectFields=facts&selectFields=movies&id=25584"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = MovieEndpoints.movieFilter.header
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error? = nil
        var statusCode: Int? = nil
        
        let dataTask = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 3.0)
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(responseError)
    }
    
    func testPersonRequestSuccess() {
        let personName = "Michael Waxman"
        interactor.personRequest()
        XCTAssertEqual(interactor.personDetailData?.docs?.first?.enName, personName)
    }
    
    func testMovieWithPersonRequestStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie?page=1&limit=10&persons.id=25584"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = MovieEndpoints.movieFilter.header
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error? = nil
        var statusCode: Int? = nil
        
        let dataTask = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 3.0)
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(responseError)
    }
    
    func testMovieWithPersonRequestSuccess() {
        let movieName = "Форсаж"
        interactor.movieWithPersonRequest()
        XCTAssertEqual(interactor.searchData?.docs.first?.name, movieName)
    }
    
    func testAwardsRequestStatusCode200() {
        let urlString = "https://api.kinopoisk.dev/v1.4/person/awards?page=1&limit=10&personId=25584&winning=true"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.allHTTPHeaderFields = MovieEndpoints.movieFilter.header
        let promise = expectation(description: "Completion handler invoked")
        var responseError: Error? = nil
        var statusCode: Int? = nil
        
        let dataTask = sut.dataTask(with: request) { _, response, error in
            responseError = error
            statusCode = (response as? HTTPURLResponse)?.statusCode
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 3.0)
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(responseError)
    }
    
    func testAwardsRequestSuccess() {
        let award = "Оскар"
        interactor.awardsRequest()
        XCTAssertEqual(interactor.awardsData?.docs.first?.nomination?.award?.title, award)
    }
}
