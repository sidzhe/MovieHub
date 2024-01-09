////
////  castViewCell.swift
////  MovieHub
////
////  Created by Igor Guryan on 29.12.2023.
////
//
//import UIKit
//
//class CastViewCell: UICollectionViewCell {
//    static let reuseID = String(describing: CastViewCell.self)
//    
//    private lazy var photoImageView: UIImageView = {
//       let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFill
//        iv.layer.cornerRadius = 24
//        iv.clipsToBounds = true
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        return iv
//    }()
//    
//    private lazy var nameLabel: UILabel = {
//        let lb = UILabel()
//        lb.font = .montserratSemiBold(size: 12)
//        lb.textAlignment = .center
//        lb.numberOfLines = 1
//        lb.textColor = .white
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        return lb
//    }()
//    
//    private lazy var roleLabel: UILabel = {
//        let lb = UILabel()
//        lb.font = .montserratMedium(size: 10)
//        lb.textAlignment = .center
//        lb.numberOfLines = 1
//        lb.textColor = .lightGray
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        return lb
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        setupView()
//        setupLayout()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupView() {
//        contentView.addSubview(photoImageView)
//        contentView.addSubview(nameLabel)
//        contentView.addSubview(roleLabel)
//    }
//    
//    private func setupLayout() {
//        photoImageView.snp.makeConstraints { make in
//            make.top.centerX.equalToSuperview()
//            make.height.width.equalTo(64)
//        }
//        
//        nameLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(photoImageView.snp.bottom).offset(8)
//        }
//        
//        roleLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(photoImageView.snp.bottom).offset(6)
//        }
//    }
//}
