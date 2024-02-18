//
//  MapPresenter.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import Foundation
import YandexMapsMobile

final class MapPresenter: MapPresenterProtocol {
    
    //MARK: Properties
    weak var view: MapViewProtocol?
    var interactor: MapInteractorInputProtocol?
    var router: MapRouterProtocol?
    
    //MARK: Get some data
    func getSelectedLocation() -> Location {
        guard let location = interactor?.selectedCityLocation else { return Location(lat: 0, lon: 0) }
        return location
    }
    
    func getUserLocation() -> Location {
        guard let location = interactor?.userLocation else { return Location(lat: 0, lon: 0) }
        return location
    }
    
    func makePinsData() -> [Datum] {
        guard let data = interactor?.cityList else { return [Datum]() }
        return data
    }
    
    //MARK: Deleting some elements
    func convertCinema(name: String?) -> String {
        guard let name = name else { return Constant.none }
        let regex = try? NSRegularExpression(pattern: Constant.regularPattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: name.utf16.count)
        let cleanedCinema = regex?.stringByReplacingMatches(in: name, options: [], range: range, withTemplate: Constant.none)
        return cleanedCinema ?? name
    }
    
    //MARK: Create YMKPoints
    func createPoints() -> [YMKPoint] {
        var points = [YMKPoint]()
        let data = makePinsData()
        
        data.forEach {
            let lat = $0.data?.general?.address?.mapPosition?.coordinates?[1] ?? 0
            let lon = $0.data?.general?.address?.mapPosition?.coordinates?[0] ?? 0
            points.append(YMKPoint(latitude: lat, longitude: lon))
        }
        
        return points
    }
    
    //MARK: Create cluster image
    func clusterImage(_ clusterSize: UInt) -> UIImage {
        let scale = UIScreen.main.scale
        let text = (clusterSize as NSNumber).stringValue
        let font = UIFont.systemFont(ofSize: 15 * scale)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
        let internalRadius = textRadius + 3 * scale
        let externalRadius = internalRadius + 3 * scale
        let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)
        
        UIGraphicsBeginImageContext(iconSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: .zero,
            size: CGSize(width: 2 * externalRadius, height: 2 * externalRadius)));
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: CGPoint(
                x: externalRadius - internalRadius,
                y: externalRadius - internalRadius
            ),
            size: CGSize(
                width: 2 * internalRadius,
                height: 2 * internalRadius))
        );
        
        (text as NSString).draw(
            in: CGRect(
                origin: CGPoint(
                    x: externalRadius - size.width / 2,
                    y: externalRadius - size.height / 2
                ),
                size: size),
            withAttributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.black])
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
}


//MARK: - Extension MapInteractorOutputProtocol
extension MapPresenter: MapInteractorOutputProtocol {
    
    func getError(_ error: String) {
        view?.displayError(error)
    }
    
    func addPins() {
        view?.addPinsToMap()
    }
}
