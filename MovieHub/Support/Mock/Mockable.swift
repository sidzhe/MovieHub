//
//  Mockable.swift
//  MovieHub
//
//  Created by sidzhe on 11.02.2024.
//

import Foundation

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func getJSON<T: Decodable>(fileName: String, type: T.Type) -> T
}


extension Mockable {
    var bundle: Bundle { Bundle(for: type(of: self)) }
    
    func getJSON<T: Decodable>(fileName: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError()
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decode = try JSONDecoder().decode(T.self, from: data)
            return decode
        } catch {
            fatalError("decode error")
        }
    }
}
