//
//  Constant.swift
//  MovieHub
//
//  Created by sidzhe on 12.01.2024.
//

import Foundation

enum Constant {
    static let ok = "OK"
    static let none = ""
    static let htmlSymbols = "<[^>]+>"
    static let format = "%.1f"
    static let utc = "UTC"
    static let png = "png"
    static let pinSpace = "• "
    static let spacePinSpace = " • "
    static let separatorN = "\n"
    static let locale = "ru_RU"
    static let localeID = "ru"
    static let dataFormatOutput = "d MMMM yyyy"
    static let dataFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    static let regularPattern = "Кинотеатр |Киноцентр |«|»"

    static let animation = "animation"
    static let animation81 = "animation81"
    static let confetti = "confetti-27-"

    static let keyClearButton = "clearButton"
    static let keyName = "name"
    static let keyAdress = "adress"
    static let oscarRu = "Оскар"
    static let cannFest = "Каннский кинофестиваль"
    static let goldGlobe = "Золотой глобус"

    static let mappinCircle = "mappin.circle"
    static let playTV = "play.tv"
    static let mapCircle = "map.circle"
    static let chevronRight = "chevron.right"
    static let cinemaIcon = "cinemaIcon"
    static let magnifyingglass = "magnifyingglass"
    static let starFill = "star.fill"
    static let personFill = "person.fill"
    static let puzzleFill = "puzzlepiece.extension.fill"
    static let yellowBall = "yellowBall"
    static let greenBall = "greenBall"
    static let xmarkCircleFill = "xmark.circle.fill"

    static let movieListCellID = "MovieListCellID"
    static let persistentContainerName = "MovieHubStorage"

    static let fatalError = "Fatal Error"
    static let unknownSection = "Unknown section"
    static let requestError = "Ошибка запроса".localized()
    static let cityNotFoundError = "Город не найден".localized()
    static let geoError = "Ошибка обратного геокодирования:".localized()
    static let localeError = "Ошибка получения текущей локации".localized()
    static let errorWithHTML = "Ошибка при удалении HTML-тегов:"
    
    static let km = "км.".localized()
    static let sm = "см.".localized()
    static let all = "Все".localized()
    static let age = "год".localized()
    static let age2 = "года".localized()
    static let age3 = "лет".localized()
    static let tree = "Елка".localized()
    static let city = "Город".localized()
    static let height = "Рост".localized()
    static let facts = "Факты".localized()
    static let search = "Поиск".localized()
    static let career = "Карьера".localized()
    static let movies = "Фильмы".localized()
    static let awards = "Награды".localized()
    static let adress = "• Адрес".localized()
    static let phone = "• Телефон".localized()
    static let cinemas = "Кинотеатры".localized()
    static let aboutCinemaDeailt = "• О кинотеатре".localized()
    static let cinemaStreet = "Кинотеатр, улица".localized()
    static let cityOnTheMap = "Кинотеатры на карте".localized()
    static let distance = "Расстояние".localized()
    static let birdDay = "Дата рождения".localized()
    static let profile = "Профиль".localized()
    static let movieList = "Cписок фильмов".localized()
    static let selectCity = "Выбор города".localized()
    static let whereAreYou = "Где вы сейчас?".localized()
    static let aboutCinema = "О кинотеатре".localized()
    static let categories = "Категории".localized()
    static let topRate = "Высокий рейтинг".localized()
    static let moviesCollection = "фильмов".localized()
    static let searchByTitle = "Поиск по названию..".localized()
}
