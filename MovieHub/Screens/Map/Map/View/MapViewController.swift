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
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        createAnimatedPlacemark()
        navigationController?.setupNavigationBar()
    }
    
    //MARK: Setup map
    private func setupMap() {
        title = Constant.cityOnTheMap
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
    
    //MARK: Create animate pin
    func createAnimatedPlacemark() {
        guard let location = presenter?.getUserLocation() else { return }
        let animatedImageProvider = YRTAnimatedImageProviderFactory.fromFile(
            Bundle.main.path(forResource: Constant.animation, ofType: Constant.png)) as! YRTAnimatedImageProvider
        let animatedPlacemark = mapView.mapWindow.map.mapObjects.addPlacemark()
        animatedPlacemark.geometry = YMKPoint(latitude: location.lat, longitude: location.lon)
        let animation = animatedPlacemark.useAnimation()
        animation.setIconWithImage(animatedImageProvider, style: YMKIconStyle()) {
            animation.play()
        }
    }
    
    //MARK: - Display alert
    private func alert(cinemaName: String, adress: String) {
        let alert = UIAlertController(title: cinemaName, message: adress, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: - Display network error
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: Constant.requestError, message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


//MARK: - Extension YMKClusterListener, YMKClusterTapListener
extension MapViewController: YMKClusterListener, YMKClusterTapListener {
    
    func onClusterAdded(with cluster: YMKCluster) {
        guard let presenter = presenter else { return }
        cluster.appearance.setIconWith(presenter.clusterImage(cluster.size))
        cluster.addClusterTapListener(with: self)
    }
    
    func onClusterTap(with cluster: YMKCluster) -> Bool {
        print("TPA TAP")
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
    
    func displayError(_ error: String) {
        Task { alertError(error) }
    }
    
    func addPinsToMap() {
        Task { [weak self] in
            guard let self = self, let presenter = presenter else { return }
            let collection = mapView.mapWindow.map.mapObjects.addClusterizedPlacemarkCollection(with: self)
            let points = presenter.createPoints()
            let placemarks = collection.addPlacemarks(with: points, image: .cinemaIcon, style: YMKIconStyle())
            
            placemarks.enumerated().forEach { (index, placemark) in
                guard let presenter = self.presenter else { return }
                let data = presenter.makePinsData()
                let name = presenter.convertCinema(name: data[index].data?.general?.name)
                let adress = data[index].data?.general?.address?.street ?? Constant.none
                placemark.addTapListener(with: self)
                placemark.userData = [Constant.keyName: name, Constant.keyAdress: adress]
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

