//
//  MapViewController.swift
//  MovieHub
//
//  Created by sidzhe on 05.01.2024.
//

import UIKit
import SnapKit
import YandexMapsMobile

final class MapViewController: UIViewController {
    
    // MARK: Properties
    var presenter: MapPresenterProtocol?
    private let mapView = YMKMapView()
    
    private let PLACEMARKS_NUMBER = 2000
    private let FONT_SIZE: CGFloat = 15
    private let MARGIN_SIZE: CGFloat = 3
    private let STROKE_SIZE: CGFloat = 3
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        createAnimatedPlacemark()
        
    }
    
    //MARK: Methods
    private func setupMap() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        guard let location = presenter?.getSelectedLocation() else { return }
        
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: YMKPoint(latitude: location.lat, longitude: location.lon),
                zoom: 15,
                azimuth: 0,
                tilt: 0
            ))
        
    }
    
    func createAnimatedPlacemark() {
        guard let location = presenter?.getUserLocation() else { return }
        let animatedImageProvider = YRTAnimatedImageProviderFactory.fromFile(
            Bundle.main.path(forResource: "animation", ofType: "png")) as! YRTAnimatedImageProvider
        let animatedPlacemark = mapView.mapWindow.map.mapObjects.addPlacemark()
        animatedPlacemark.geometry = YMKPoint(latitude: location.lat, longitude: location.lon)
        let animation = animatedPlacemark.useAnimation()
        animation.setIconWithImage(animatedImageProvider, style: YMKIconStyle()) {
            animation.play()
        }
    }
    
    private func addPlacemark(_ map: YMKMap) {
        guard let presenter = presenter else { return }
        let data = presenter.makePinsData()
        
        data.forEach {
            let lat = $0.data?.general?.address?.mapPosition?.coordinates?[1] ?? 0
            let lon = $0.data?.general?.address?.mapPosition?.coordinates?[0] ?? 0
            let name = presenter.convertCinema(name: $0.data?.general?.name)
            let image = UIImage(named: "cinemaIcon") ?? UIImage()
            Task {
                let placemark = map.mapObjects.addPlacemark()
                placemark.geometry = YMKPoint.init(latitude: lat, longitude: lon)
                placemark.setIconWith(image)
                placemark.addTapListener(with: self)
                placemark.setTextWithText(
                    name,
                    style: {
                        let textStyle = YMKTextStyle()
                        textStyle.size = 8.0
                        textStyle.placement = .bottom
                        textStyle.offset = 5.0
                        return textStyle
                    }()
                )
            }
        }
    }
    
    func createPoints() -> [YMKPoint]{
        var points = [YMKPoint]()
        let data = presenter!.makePinsData()
        
        data.forEach {
            let lat = $0.data?.general?.address?.mapPosition?.coordinates?[1] ?? 0
            let lon = $0.data?.general?.address?.mapPosition?.coordinates?[0] ?? 0
            points.append(YMKPoint(latitude: lat, longitude: lon))
        }
        
        return points
    }
    
    func clusterImage(_ clusterSize: UInt) -> UIImage {
        let scale = UIScreen.main.scale
        let text = (clusterSize as NSNumber).stringValue
        let font = UIFont.systemFont(ofSize: FONT_SIZE * scale)
        let size = text.size(withAttributes: [NSAttributedString.Key.font: font])
        let textRadius = sqrt(size.height * size.height + size.width * size.width) / 2
        let internalRadius = textRadius + MARGIN_SIZE * scale
        let externalRadius = internalRadius + STROKE_SIZE * scale
        let iconSize = CGSize(width: externalRadius * 2, height: externalRadius * 2)
        
        UIGraphicsBeginImageContext(iconSize)
        let ctx = UIGraphicsGetCurrentContext()!
        
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: .zero,
            size: CGSize(width: 2 * externalRadius, height: 2 * externalRadius)));
        
        ctx.setFillColor(UIColor.white.cgColor)
        ctx.fillEllipse(in: CGRect(
            origin: CGPoint(x: externalRadius - internalRadius, y: externalRadius - internalRadius),
            size: CGSize(width: 2 * internalRadius, height: 2 * internalRadius)));
        
        (text as NSString).draw(
            in: CGRect(
                origin: CGPoint(x: externalRadius - size.width / 2, y: externalRadius - size.height / 2),
                size: size),
            withAttributes: [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.black])
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        return image
    }
    
    //MARK: - Display alert
    private func alert(cinemaName: String, adress: String) {
        let alert = UIAlertController(title: cinemaName, message: adress, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


//MARK: - Extension YMKClusterListener, YMKClusterTapListener
extension MapViewController: YMKClusterListener, YMKClusterTapListener {
    
    func onClusterAdded(with cluster: YMKCluster) {
        // We setup cluster appearance and tap handler in this method
        cluster.appearance.setIconWith(clusterImage(cluster.size))
        cluster.addClusterTapListener(with: self)
    }
    
    func onClusterTap(with cluster: YMKCluster) -> Bool {
        return true
    }
}

//MARK: - Extension YMKMapObjectTapListener
extension MapViewController: YMKMapObjectTapListener {
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if let placemark = mapObject as? YMKPlacemarkMapObject {
            if let userData = placemark.userData as? [String: Any] {
                if let name = userData["name"] as? String,
                   let adress = userData["adress"] as? String {
                    alert(cinemaName: name, adress: adress)
                }
            }
        }
        return true
    }
}


//MARK: - Extension MapViewProtocol
extension MapViewController: MapViewProtocol {
    func addPinsToMap() {
        
        Task { [weak self] in
            guard let self = self else { return }
            let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)
            let points = createPoints()
            let placemarks = collection.addPlacemarks(with: points, image: UIImage(named: "cinemaIcon") ?? UIImage(), style: YMKIconStyle())
            
            placemarks.enumerated().forEach { (index, placemark) in
                guard let presenter = self.presenter else { return }
                let data = presenter.makePinsData()
                let name = presenter.convertCinema(name: data[index].data?.general?.name)
                let adress = data[index].data?.general?.address?.fullAddress ?? ""
                placemark.addTapListener(with: self)
                placemark.userData = ["name": name, "adress": adress]
                placemark.setTextWithText(
                    name,
                    style: {
                        let textStyle = YMKTextStyle()
                        textStyle.size = 10.0
                        textStyle.placement = .bottom
                        textStyle.offset = 5.0
                        return textStyle
                    }()
                )
            }
            
            collection.clusterPlacemarks(withClusterRadius: 60, minZoom: 15)
        }
    }
}

