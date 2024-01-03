//
//  PersonDetailViewController.swift
//  MovieHub
//
//  Created by sidzhe on 02.01.2024.
//

import UIKit
import SnapKit

final class PersonDetailViewController: UIViewController {
    
    //MARK: Properties
    var presenter:  PersonDetailPresenterProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Doc>?
    
    private let avatar: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var birdDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var careerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureCollectionView()
        createDataSource()
        applySnapshot()
        
    }
    
    //MARK: Setup UI
    private func setupViews() {
        view.backgroundColor = .primaryDark
        
        view.addSubview(avatar)
        view.addSubview(nameLabel)
        view.addSubview(birdDayLabel)
        view.addSubview(careerLabel)
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(220)
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatar.snp.right).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview().inset(24)
        }
        
        birdDayLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
        
        careerLabel.snp.makeConstraints { make in
            make.top.equalTo(birdDayLabel.snp.bottom).offset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
    }
    
    //MARK: Set titles
    private func setTitles() {
        guard let presenter = presenter, let model = presenter.getPersonDetailData()?.docs?.first else { return }
        
        let birthDay = presenter.dateFormatter(model.birthday)
        let age = presenter.formatAgeString(age: model.age)
        let career = presenter.convertModel(model: model.profession)
        
        nameLabel.text = model.name
        
        let birdDayLabelText = "Дата рождения\n\(birthDay)\n • \(age)\n • \(model.birthPlace?.last?.value ?? "")"
        let attributedDirdDay = NSMutableAttributedString(string: birdDayLabelText)
        attributedDirdDay.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 13))
        birdDayLabel.attributedText = attributedDirdDay
        
        let careerLabelText = "Карьера\n\(career)"
        let attributedString = NSMutableAttributedString(string: careerLabelText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 7))
        careerLabel.attributedText = attributedString
        
        Task {
            guard let url = URL(string: model.photo ?? "") else { return }
            avatar.kf.setImage(with: url)
        }
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: "Request error", message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - Extension PersonDetailViewController
private extension PersonDetailViewController {
    
    //MARK: Create Laouyt
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let section: NSCollectionLayoutSection
            
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.65))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 16, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(500))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else {
                fatalError("Unkown section")
            }
            
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    //MARK: Setup collection view
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView?.snp.makeConstraints({ make in
            make.top.equalTo(avatar.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(90)
        })
    }
    
    //MARK: Regisration
    func registrationMovies() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getSearchData() else { return }
            cell.configure(category: model[indexPath.row])
        }
    }
    
    func registrationHeader() -> UICollectionView.SupplementaryRegistration<PersonHeader> {
        return UICollectionView.SupplementaryRegistration<PersonHeader> (elementKind: UICollectionView.elementKindSectionHeader)
        { [weak self] header, _, indexPath in
            guard let model = self?.presenter?.getPersonDetailData()?.docs,
                  let awardsModel = self?.presenter?.getAwardsData() else { return }
            header.configureAwards(awardsModel.first)
            header.configure(model.first)
        }
    }
    
    //MARK: Create dataSource
    func createDataSource() {
        let registrationMovies = registrationMovies()
        let registrationHeader = registrationHeader()
        
        dataSource = UICollectionViewDiffableDataSource<Int, Doc>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            switch indexPath.section {
            case 0:
                return collectionView.dequeueConfiguredReusableCell(using: registrationMovies, for: indexPath, item: item)
            default:
                return nil
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                
                switch indexPath.section {
                case 0:
                    return collectionView.dequeueConfiguredReusableSupplementary(using: registrationHeader, for: indexPath)
                default:
                    return nil
                }
            }
            return nil
        }
    }
    
    //MARK: applySnapshot
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Doc>()
        guard let presenter = presenter else { return }
        snapshot.appendSections([.min])
        guard let item = presenter.getSearchData() else { return }
        snapshot.appendItems(item, toSection: .min)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension UICollectionViewDelegate
extension PersonDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.routeToDetail()
    }
}

//MARK: - Extension PersonDetailViewProtocol
extension PersonDetailViewController: PersonDetailViewProtocol {
    
    //MARK: Update UI
    func updateUI() {
        Task {
            setTitles()
            applySnapshot()
        }
    }
    
    //MARK: Get display error
    func displayRequestError(_ error: RequestError) {
        Task { alertError(error) }
    }
}
