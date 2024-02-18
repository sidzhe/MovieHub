//
//  TestPresenterTest.swift
//  MovieHubTests
//
//  Created by sidzhe on 17.02.2024.
//

import XCTest
@testable import MovieHub

final class TestPresenterTest: XCTestCase {
    
    var interactor: TrailerInteractor!
    var presenter: TrailerPresenter!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = TrailerPresenter()
        interactor = TrailerInteractor(detailModel: nil)
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        presenter = nil
        interactor = nil
        try super.tearDownWithError()
    }
    
    func testMakeTrailer() {
        let detail = DetailModel(
            id: nil,
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
            persons: nil,
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
            videos: Videos(trailers: [Trailer(url: "https://testUrl.com/idTest", name: nil, site: nil, type: nil)]),
            premiere: nil,
            ticketsOnSale: nil,
            audience: nil,
            isSeries: nil,
            seriesLength: nil,
            totalSeriesLength: nil,
            logo: nil,
            lists: nil
        )
        
        interactor.detailModel = detail
        let id = presenter.makeTrailerId()
        XCTAssertEqual(id, "idTest")
    }
}
