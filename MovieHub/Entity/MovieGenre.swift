//
//  MovieGenre.swift
//  MovieHub
//
//  Created by sidzhe on 26.12.2023.
//

import Foundation

enum MovieGenre: String, CaseIterable {
    case all = "все"
    case anime = "аниме"
    case biografiya = "биография"
    case boevik = "боевик"
    case vestern = "вестерн"
    case voennyy = "военный"
    case detektiv = "детектив"
    case detskiy = "детский"
    case dokumentalnyy = "документальный"
    case drama = "драма"
    case istoriya = "история"
    case komediya = "комедия"
    case korotkometrazhka = "короткометражка"
    case kriminal = "криминал"
    case melodrama = "мелодрама"
    case muzyka = "музыка"
    case multfilm = "мультфильм"
    case myuzikl = "мюзикл"
    case novosti = "новости"
    case priklyucheniya = "приключения"
    case realnoeTV = "реальное ТВ"
    case semeynyy = "семейный"
    case sport = "спорт"
    case triller = "триллер"
    case uzhasy = "ужасы"
    case fantastika = "фантастика"
    case fentezi = "фэнтези"
}
