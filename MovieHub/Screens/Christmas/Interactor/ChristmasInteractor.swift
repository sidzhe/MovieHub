//
//  ChristmasInteractor.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

final class ChristmasInteractor: ChristmasInteractorInputProtocol {
    
    //MARK: Properties
    weak var presenter: ChristmasInteractorOutputProtocol?
    private let networkService: NetworkServiceProtocol
    private let newYearMovies = ["8124", "348", "5928", "6144", "6851", "84052", "986", "807339", "90207", "664",
                                 "1117379", "104927", "22328", "38905", "79440", "5942", "6133", "1828", "391755", "7114",
                                 "577558", "2737", "10074", "95194", "1646", "9262", "258636", "493768", "77331", "42664"]
    
    var loadedMovie: DetailModel? { didSet { previousModel = oldValue }}
    var previousModel: DetailModel?
    
    //MARK: Init
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    //MARK: Search movie
    func getMovieWithId() {
        networkService.searchDetailID(newYearMovies[Int.random(in: 0..<30)]) { [weak self] (result: (Result<DetailModel, RequestError>)) in
            switch result {
                
            case .success(let movie):
                self?.loadedMovie = movie
            case .failure(let error):
                self?.presenter?.getRequsetError(error)
            }
        }
    }
}
