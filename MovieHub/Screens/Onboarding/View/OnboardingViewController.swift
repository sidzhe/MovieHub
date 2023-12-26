//
//  OnboardingViewController.swift
//  MovieHub
//
//  Created by sidzhe on 24.12.2023.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    //MARK: Properties
    var presenter: OnboardingPresenterProtocol?
    let networkkService = NetworkkService()
    let imageView = UIImageView()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
        view.backgroundColor = .yellow
        
        //        networkkService.searchPerson("Арнольд Шварцнегер") { [weak self] (result: (Result<PersonModel, RequestError>)) in
        //            switch result {
        //
        //            case .success(let data):
        //                print(data)
        //                self?.imageLoad(url: data.docs.first?.photo)
        //            case .failure(let error):
        //                print(error.customMessage)
        //            }
        //        }
        //
        //        networkkService.searchID("666") { [weak self] (result: (Result<DetailModel, RequestError>)) in
        //            switch result {
        //
        //            case .success(let data):
        //                print("!!!!!!!!! \(data)")
        //            case .failure(let error):
        //                print(error.customMessage)
        //            }
        //        }
        
        networkkService.searchColletions { [weak self] (result: (Result<ColletionModel, RequestError>)) in
            switch result {
                
            case .success(let data):
                print("!!!!!!!!! \(data)")
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
    
    func imageLoad(url: String?) {
        networkkService.loadImage(url)
        { [weak self] (result: (Result<UIImage, RequestError>)) in
            switch result {
                
            case .success(let image):
                Task {
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(error.customMessage)
            }
        }
    }
}


//MARK: - Extension OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewProtocol {
    
}
