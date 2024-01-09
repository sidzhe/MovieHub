//
//  DetailCinemaPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 06.01.2024.
//

import Foundation

final class DetailCinemaPresenter: DetailCinemaPresenterProtocol {
    
    //MARK: Properties
    weak var view: DetailCinemaViewProtocol?
    var cinemaModel: GlobeCinema
    
    //MARK: Init
    init(cinema: GlobeCinema) {
        self.cinemaModel = cinema
    }
    
    //MARK: Convert string from GlobeCimena
    func getCinemaDescription() -> String {
        guard let model = removingHTMLEscapes(text: cinemaModel.description) else { return "" }
        return model
    }
    
    private func removingHTMLEscapes(text: String?) -> String? {
        guard let text = text else { return nil }
        
        do {
            let regex = try NSRegularExpression(pattern: "<[^>]+>", options: .caseInsensitive)
            let range = NSRange(location: 0, length: text.utf16.count)
            let htmlFreeString = regex.stringByReplacingMatches(in: text, options: [], range: range, withTemplate: "")
            return htmlFreeString
        } catch {
            print("Ошибка при удалении HTML-тегов: \(error)")
            return nil
        }
    }
}


