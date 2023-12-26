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
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
    }
}


//MARK: - Extension OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewProtocol {
    
}
