//
//  Protocols.swift
//  MovieHub
//
//  Created by sidzhe on 25.12.2023.
//

import Foundation

/// PRESENTER -> VIEW
protocol TabBarViewProtocol: AnyObject {
    var presenter: TabBarPresenterProtocol? { get set }
}

/// VIEW -> PRESENTER
protocol TabBarPresenterProtocol: AnyObject {
    var view: TabBarViewProtocol? { get set }
    var previousViewTag: Int? { get set }
}
