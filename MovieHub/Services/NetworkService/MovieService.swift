//
//  MovieService.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import UIKit

//MARK: - MovieServiceProtool
protocol MovieServiceProtool {
    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError>
    func searchPerson<T: Decodable>(person: String) async -> Result<T, RequestError>
    func searchWithId<T: Decodable>(identifier: String) async -> Result<T, RequestError>
    func searchCollection<T: Decodable>() async -> Result<T, RequestError>
    func movieFilterSlug<T: Decodable>(slugTag: String) async -> Result<T, RequestError>
    func movieFilterGenres<T: Decodable>(genre: String) async -> Result<T, RequestError>
    func movieFilterRate<T: Decodable>(genre: String) async -> Result<T, RequestError>
    func movieFilterPerson<T: Decodable>(actorsId: [Int]) async -> Result<T, RequestError>
    func movieWirhPerosn<T: Decodable>(actorsId: Int) async -> Result<T, RequestError>
    func awardsPerson<T: Decodable>(actorsId: Int) async -> Result<T, RequestError>
    func movieUpcomingGenres<T: Decodable>(genre: String) async -> Result<T, RequestError>
    func getCinimaList<T: Decodable>(city: String) async -> Result<T, RequestError>
    func getCurrentCity<T: Decodable>(cityName: String) async -> Result<T, RequestError>
    func searchMovieById<T: Decodable>(identifiers: [String]) async -> Result<T, RequestError>
}


//MARK: - MovieService
struct MovieService: MovieServiceProtool, MovieClient {
    
    //MARK: Search movie with title
    func searchMovie<T: Decodable>(searchTitle: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchTitle
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "query", value: searchTitle), URLQueryItem(name: "limit", value: "10")]
        urlComponents.queryItems = items
        print(urlComponents.url)
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchTitle, responseModel: T.self)
    }
    
    //MARK: Search person with name
    func searchPerson<T: Decodable>(person: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchPerson
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "query", value: person), URLQueryItem(name: "limit", value: "10")]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchPerson, responseModel: T.self)
    }
    
    //MARK: Search movie with id
    func searchWithId<T: Decodable>(identifier: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchDetailById
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path + identifier
        urlComponents.queryItems = endpoint.item
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchDetailById, responseModel: T.self)
    }
    
    //MARK: Get slug collection
    func searchCollection<T: Decodable>() async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.slugList
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.item
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.slugList, responseModel: T.self)
    }
    
    //MARK: Get collection
    func movieFilterSlug<T: Decodable>(slugTag: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "lists", value: slugTag)]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieFilter, responseModel: T.self)
    }
    
    //MARK: Gesre's collection
    func movieFilterGenres<T: Decodable>(genre: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "genres.name", value: genre)]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieFilter, responseModel: T.self)
    }
    
    //MARK: Rated moveies
    func movieFilterRate<T: Decodable>(genre: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        var items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "rating.kp", value: "4.5-10")]
        if genre != "все" {
            let item = URLQueryItem(name: "genres.name", value: genre)
            items.append(item)
        }
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieFilter, responseModel: T.self)
    }
    
    //MARK: Related person
    func movieFilterPerson<T: Decodable>(actorsId: [Int]) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.personFilter
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        var items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "selectFields", value: "name"),
                     URLQueryItem(name: "selectFields", value: "enName"),
                     URLQueryItem(name: "selectFields", value: "photo"),
                     URLQueryItem(name: "selectFields", value: "growth"),
                     URLQueryItem(name: "selectFields", value: "birthday"),
                     URLQueryItem(name: "selectFields", value: "age"),
                     URLQueryItem(name: "selectFields", value: "birthPlace"),
                     URLQueryItem(name: "selectFields", value: "spouses"),
                     URLQueryItem(name: "selectFields", value: "profession"),
                     URLQueryItem(name: "selectFields", value: "facts"),
                     URLQueryItem(name: "selectFields", value: "movies")
        ]
        let anotherItems = actorsId.map { URLQueryItem(name: "id", value: String($0))}
        items.append(contentsOf: anotherItems)
        urlComponents.queryItems = items
        
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.personFilter, responseModel: T.self)
    }
    
    //MARK: Movie with person
    func movieWirhPerosn<T: Decodable>(actorsId: Int) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.movieWithPerson
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "persons.id", value: actorsId.description)]
        urlComponents.queryItems = items
        
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.movieWithPerson, responseModel: T.self)
    }
    
    //MARK: Awards person
    func awardsPerson<T: Decodable>(actorsId: Int) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.awards
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "page", value: "1"),
                     URLQueryItem(name: "limit", value: "10"),
                     URLQueryItem(name: "personId", value: actorsId.description),
                     URLQueryItem(name: "winning", value: "true")]
        urlComponents.queryItems = items
        
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.awards, responseModel: T.self)
    }
    
    //MARK: upcoming with gesres
    func movieUpcomingGenres<T: Decodable>(genre: String) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.upcoming
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        var items = [URLQueryItem(name: "page", value: "1"),
                              URLQueryItem(name: "limit", value: "10"),
                              URLQueryItem(name: "notNullFields", value: "name"),
                              URLQueryItem(name: "notNullFields", value: "year"),
                              URLQueryItem(name: "notNullFields", value: "poster.url"),
                              URLQueryItem(name: "status", value: "announced"),
                              URLQueryItem(name: "status", value: "filming"),
                              URLQueryItem(name: "status", value: "post-production"),
                              URLQueryItem(name: "status", value: "pre-production")]
        if genre != "все" {
            let item = URLQueryItem(name: "genres.name", value: genre)
            items.append(item)
        }
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.upcoming, responseModel: T.self)
    }
    
    //MARK: Get cinema list
    func getCinimaList<T: Decodable>(city: String) async -> Result<T, RequestError> {
        let endpoint = CinemaEndpoints.getMovieList
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = "opendata.mkrf.ru"
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "f", value: "{\"data.general.locale.name\":{\"$eq\":\"\(city)\"}}")]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: CinemaEndpoints.getMovieList, responseModel: T.self)
    }
    
    //MARK: Get current city
    func getCurrentCity<T: Decodable>(cityName: String) async -> Result<T, RequestError> {
        let endpoint = CurrentCityEndpoints.getCurrentCity
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = "geocode-maps.yandex.ru"
        urlComponents.path = endpoint.path
        let items = [URLQueryItem(name: "apikey", value: "bbd6c3a0-90a5-48c4-9903-d375e1f53b2c"),
                     URLQueryItem(name: "geocode", value: "\(cityName)"),
                     URLQueryItem(name: "format", value: "json")]
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: CurrentCityEndpoints.getCurrentCity, responseModel: T.self)
    }
    
    //MARK: Search movie by id
    func searchMovieById<T: Decodable>(identifiers: [String]) async -> Result<T, RequestError> {
        let endpoint = MovieEndpoints.searchMovieById
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        var items = [URLQueryItem(name: "page", value: "1"), URLQueryItem(name: "limit", value: "10")]
        identifiers.forEach { items.append(URLQueryItem(name: "id", value: $0))}
        urlComponents.queryItems = items
        return await sendRequest(urlComponents: urlComponents, endpoint: MovieEndpoints.searchMovieById, responseModel: T.self)
    }
}

