//
//  TrailerPresenterTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 10.02.2024.
//

import XCTest
@testable import MovieHub

class MockInteractor: TrailerInteractorInputProtocol {
    var presenter: TrailerInteractorOutputProtocol?
    var detailModel: DetailModel?
    var urlImages: [GaleryDoc]?
    
    func setDetail() {
        self.detailModel = DetailModel(id: nil,
                                       externalId: nil,
                                       name: nil,
                                       alternativeName: nil,
                                       enName: nil,
                                       names: nil,
                                       type: nil,
                                       typeNumber: nil,
                                       year: nil,
                                       description: nil,
                                       shortDescription: nil,
                                       slogan: nil,
                                       status: nil,
                                       rating: nil,
                                       votes: nil,
                                       movieLength: nil,
                                       ratingMPAA: nil,
                                       ageRating: nil,
                                       poster: nil,
                                       backdrop: nil,
                                       genres: nil,
                                       countries: nil,
                                       persons: [Person(id: 1, photo: "url", name: "person1", enName: nil, personDescription: "person1", profession: "actor", enProfession: nil),
                                                 Person(id: 2, photo: "url2", name: "person2", enName: nil, personDescription: "person2", profession: "actor", enProfession: nil)],
                                       budget: nil,
                                       fees: nil,
                                       sequelsAndPrequels: nil,
                                       watchability: nil,
                                       top10: nil,
                                       top250: nil,
                                       facts: nil,
                                       similarMovies: nil,
                                       createdAt: nil,
                                       updatedAt: nil,
                                       videos: nil,
                                       premiere: nil,
                                       ticketsOnSale: nil,
                                       audience: nil,
                                       isSeries: nil,
                                       seriesLength: nil,
                                       totalSeriesLength: nil,
                                       logo: nil,
                                       lists: nil)
    }
}

class TrailerPresenterTests: XCTestCase {
    
    var presenter: TrailerPresenter!
    var mockInteractor: TrailerInteractorInputProtocol!
    
    override func setUp() {
        super.setUp()

        mockInteractor = MockInteractor()
        presenter = TrailerPresenter()
        presenter.interactor = mockInteractor
    }
    
    override func tearDown() {
        mockInteractor = nil
        presenter = nil
        super.tearDown()
    }
    
    func testGetPerson() {
        // Arrange
        let person = [Person(id: 1, photo: "url", name: "person1", enName: nil, personDescription: "person1", profession: "actor", enProfession: nil),
                      Person(id: 2, photo: "url2", name: "person2", enName: nil, personDescription: "person2", profession: "actor", enProfession: nil)]
        
        (mockInteractor as! MockInteractor).setDetail()
        
        // Act
        let resultPersons = presenter.getPerson()
        
        // Assert
        XCTAssertEqual(resultPersons, person, "The returned persons should match the expected persons.")
    }
}
