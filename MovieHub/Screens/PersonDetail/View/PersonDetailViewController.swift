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
    private var dataSource: UICollectionViewDiffableDataSource<PersonSection, PersonItem>?
    
    private let avatar: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratBold(size: 16)
        label.textColor = .white
        return label
    }()
    
    private lazy var growthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.montserratMedium(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
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
        view.addSubview(growthLabel)
        view.addSubview(careerLabel)
        
        avatar.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(250)
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
        
        growthLabel.snp.makeConstraints { make in
            make.top.equalTo(birdDayLabel.snp.bottom).offset(12)
            make.left.equalTo(avatar.snp.right).offset(20)
            make.right.equalToSuperview().inset(24)
        }
        
        careerLabel.snp.makeConstraints { make in
            make.top.equalTo(growthLabel.snp.bottom).offset(12)
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
        let growth = model.growth ?? 0
        
        nameLabel.text = model.name
        
        let birdDayLabelText = "\(Constant.birdDay)\n\(birthDay)\n • \(age)\n • \(model.birthPlace?.last?.value ?? Constant.none)"
        let attributedBirdDay = NSMutableAttributedString(string: birdDayLabelText)
        attributedBirdDay.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 13))
        birdDayLabel.attributedText = attributedBirdDay
        
        let growthLabelLabelText = "\(Constant.height)\n\(growth) \(Constant.sm)"
        let attributedGrowthLabel = NSMutableAttributedString(string: growthLabelLabelText)
        attributedGrowthLabel.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 6))
        growthLabel.attributedText = attributedGrowthLabel
        
        let careerLabelText = "\(Constant.career)\n\(career)"
        let attributedString = NSMutableAttributedString(string: careerLabelText)
        attributedString.addAttribute(.foregroundColor, value: UIColor.primaryBlue, range: NSRange(location: 0, length: 7))
        careerLabel.attributedText = attributedString
        
        Task {
            guard let url = URL(string: model.photo ?? Constant.none) else { return }
            avatar.kf.setImage(with: url)
        }
    }
    
    //MARK: - Display network error
    private func alertError(_ error: RequestError) {
        let alert = UIAlertController(title: Constant.requestError, message: error.customMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

//MARK: - Extension PersonDetailViewController
private extension PersonDetailViewController {
    
    //MARK: Create Laouyt
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = PersonSection(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .awards {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 16, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .facts {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .fractionalHeight(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 16, trailing: 16)
                
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else if sectionKind == .movies {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalWidth(0.65))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 15
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 16, trailing: 16)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top)
                sectionHeader.pinToVisibleBounds = false
                sectionHeader.zIndex = 2
                section.boundarySupplementaryItems = [sectionHeader]
                
            } else {
                fatalError(Constant.unknownSection)
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
            make.top.equalTo(avatar.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(90)
        })
    }
    
    //MARK: Regisration
    func registrationAwards() -> UICollectionView.CellRegistration<AwardCell, DocAwards> {
        return UICollectionView.CellRegistration<AwardCell, DocAwards> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getAwardsData() else { return }
            cell.configure(model[indexPath.row])
        }
    }
    
    func registrationFacts() -> UICollectionView.CellRegistration<FactsCell, String> {
        return UICollectionView.CellRegistration<FactsCell, String> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getFacts() else { return }
            cell.configure(model[indexPath.row])
        }
    }
    
    func registrationMovies() -> UICollectionView.CellRegistration<PopularCell, Doc> {
        return UICollectionView.CellRegistration<PopularCell, Doc> { [weak self] cell, indexPath, itemIdentifier in
            guard let model = self?.presenter?.getSearchData() else { return }
            cell.configure(category: model[indexPath.row])
        }
    }
    
    func registrationMovieHeader() -> UICollectionView.SupplementaryRegistration<HeaderCell> {
        return UICollectionView.SupplementaryRegistration<HeaderCell> (elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.callBackButton = { [weak self] in self?.presenter?.routeToPopular() }
            header.configure(header: Constant.movies)
        }
    }
    
    func registrationAwardsHeader() -> UICollectionView.SupplementaryRegistration<PersonHeader> {
        return UICollectionView.SupplementaryRegistration<PersonHeader> (elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.configure(header: Constant.awards)
        }
    }
    
    func registrationFactsHeader() -> UICollectionView.SupplementaryRegistration<PersonHeader> {
        return UICollectionView.SupplementaryRegistration<PersonHeader> (elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.configure(header: Constant.facts)
        }
    }
    
    //MARK: Create dataSource
    func createDataSource() {
        let registrationAwards = registrationAwards()
        let registrationFacts = registrationFacts()
        let registrationMovies = registrationMovies()
        let registrationHeader = registrationMovieHeader()
        let registrationAwardsHeader = registrationAwardsHeader()
        let registrationFactsHeader = registrationFactsHeader()
        
        dataSource = UICollectionViewDiffableDataSource<PersonSection, PersonItem>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let sectionKind = PersonSection(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .awards:
                return collectionView.dequeueConfiguredReusableCell(using: registrationAwards, for: indexPath, item: item.awards)
            case .facts:
                return collectionView.dequeueConfiguredReusableCell(using: registrationFacts, for: indexPath, item: item.facts)
            case .movies:
                return collectionView.dequeueConfiguredReusableCell(using: registrationMovies, for: indexPath, item: item.movies)
                
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = PersonSection(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .awards:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: registrationAwardsHeader, for: indexPath)
                    case .facts:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: registrationFactsHeader, for: indexPath)
                    case .movies:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: registrationHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    //MARK: applySnapshot
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<PersonSection, PersonItem>()
        guard let presenter = presenter else { return }
        
        let awards = presenter.getAwardsData().map { PersonItem(awards: $0) }
        let facts = presenter.getFacts().map { PersonItem(facts: $0) }
        let movies = presenter.getSearchData().map { PersonItem(movies: $0) }
        
        snapshot.appendSections([.awards, .facts, .movies])
        snapshot.appendItems(awards, toSection: .awards)
        snapshot.appendItems(facts, toSection: .facts)
        snapshot.appendItems(movies, toSection: .movies)
        
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}


//MARK: - Extension UICollectionViewDelegate
extension PersonDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 2 {
            presenter?.routeToDetail()
        }
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
