//
//  NetwrorkService.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

//MARK: - NetworkServiceProtool
protocol NetworkServiceProtool: AnyObject {
    func searchMovieByTitle(_ title: String, completion: @escaping (Result<SearchModel, RequestError>) -> Void)
    func searchPerson(_ person: String, completion: @escaping (Result<PersonModel, RequestError>) -> Void)
    func searchDetailID(_ identifier: String, completion: @escaping (Result<DetailModel, RequestError>) -> Void)
    func searchColletions(completion: @escaping (Result<ColletionModel, RequestError>) -> Void)
    func getSlugCollection<T: Decodable>(slugTag: String, completion: @escaping (Result<T, RequestError>) -> Void)
    func getGenreCollection(genre: MovieGenre, completion: @escaping (Result<SearchModel, RequestError>) -> Void)
    func getRateCollection(genre: MovieGenre, completion: @escaping (Result<CollectionDetailModel, RequestError>) -> Void)
    func getDetailPerson(personId: [Int], completion: @escaping (Result<PersonDetalModel, RequestError>) -> Void)
    func getMovieWithPerson(personId: Int, completion: @escaping (Result<SearchModel, RequestError>) -> Void)
    func getAwardsPerson(personId: Int, completion: @escaping (Result<AwardsModel, RequestError>) -> Void)
    func getMovieUpcomingByGenres(genre: MovieGenre, completion: @escaping (Result<UpcomingModel, RequestError>) -> Void)
    func getCityList(city: String, completion: @escaping (Result<CinemaModel, RequestError>) -> Void)
    func getCurrentCity(city: String, completion: @escaping (Result<CurrentCityModel, RequestError>) -> Void)
    func searchMovieById(identifier: String, completion: @escaping (Result<SearchModel, RequestError>) -> Void)
}


//MARK: - NetworkkService
final class NetworkService: NetworkServiceProtool {
    
    //MARK: Properties
    private let movieService = MovieService()
    
    //MARK: Search with title
    func searchMovieByTitle(_ title: String, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        Task {
            let result: Result<SearchModel, RequestError> = await movieService.searchMovie(searchTitle: title)
            completion(result)
        }
    }
    
    //MARK: Search with person
    func searchPerson(_ person: String, completion: @escaping (Result<PersonModel, RequestError>) -> Void) {
        Task {
            let result: Result<PersonModel, RequestError> = await movieService.searchPerson(person: person)
            completion(result)
        }
    }
    
    //MARK: Search with ID
    func searchDetailID(_ identifier: String, completion: @escaping (Result<DetailModel, RequestError>) -> Void) {
        Task {
            let result: Result<DetailModel, RequestError> = await movieService.searchWithId(identifier: identifier)
            completion(result)
        }
    }
    
    //MARK: Get collections
    func searchColletions(completion: @escaping (Result<ColletionModel, RequestError>) -> Void) {
        Task {
            let result: Result<ColletionModel, RequestError> = await movieService.searchCollection()
            completion(result)
        }
    }
    
    //MARK: Get Movie with slug
    func getSlugCollection<T: Decodable>(slugTag: String, completion: @escaping (Result<T, RequestError>) -> Void) {
        Task {
            let result: Result<T, RequestError> = await movieService.movieFilterSlug(slugTag: slugTag)
            completion(result)
        }
    }
    
    //MARK: Get Movie with genre
    func getGenreCollection(genre: MovieGenre, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        Task {
            let result: Result<SearchModel, RequestError> = await movieService.movieFilterGenres(genre: genre.rawValue)
            completion(result)
        }
    }
    
    //MARK: Get rate movies
    func getRateCollection(genre: MovieGenre, completion: @escaping (Result<CollectionDetailModel, RequestError>) -> Void) {
        Task {
            let result: Result<CollectionDetailModel, RequestError> = await movieService.movieFilterRate(genre: genre.rawValue)
            completion(result)
        }
    }
    
    //MARK: Movie related person
    func getDetailPerson(personId: [Int], completion: @escaping (Result<PersonDetalModel, RequestError>) -> Void) {
        Task {
            let result: Result<PersonDetalModel, RequestError> = await movieService.movieFilterPerson(actorsId: personId)
            completion(result)
        }
    }
    
    //MARK: Movie with person
    func getMovieWithPerson(personId: Int, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
        Task {
            let result: Result<SearchModel, RequestError> = await movieService.movieWirhPerosn(actorsId: personId)
            completion(result)
        }
    }
    
    //MARK: Person awards
    func getAwardsPerson(personId: Int, completion: @escaping (Result<AwardsModel, RequestError>) -> Void) {
        Task {
            let result: Result<AwardsModel, RequestError> = await movieService.awardsPerson (actorsId: personId)
            completion(result)
        }
    }
    
    //MARK: Person awards
    func getMovieUpcomingByGenres(genre: MovieGenre, completion: @escaping (Result<UpcomingModel, RequestError>) -> Void) {
        Task {
            let result: Result<UpcomingModel, RequestError> = await movieService.movieUpcomingGenres(genre: genre.rawValue)
            completion(result)
        }
    }
    
    //MARK: City list
    func getCityList(city: String, completion: @escaping (Result<CinemaModel, RequestError>) -> Void) {
        Task {
            let result: Result<CinemaModel, RequestError> = await movieService.getCinimaList(city: city)
            completion(result)
        }
    }
    
    //MARK: Current location -> city
    func getCurrentCity(city: String, completion: @escaping (Result<CurrentCityModel, RequestError>) -> Void) {
        Task {
            let result: Result<CurrentCityModel, RequestError> = await movieService.getCurrentCity(cityName: city)
            completion(result)
        }
    }
    
    //MARK: Search movie by identificator
    func searchMovieById(identifier: String, completion: @escaping (Result<SearchModel, RequestError>) -> Void) {
           Task {
               let result: Result<SearchModel, RequestError> = await movieService.searchMovieById(identifier: identifier)
               completion(result)
           }
       }
}
