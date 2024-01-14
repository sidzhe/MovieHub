//
//  TrailerViewController.swift
//  MovieHub
//
//  Created by sidzhe on 13.01.2024.
//

import UIKit
import SnapKit
import YouTubeiOSPlayerHelper

final class TrailerViewController: UIViewController {
    
    //MARK: Properties
    var presenter: TrailerPresenterProtocol?
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<SectionTrailer, ItemTrailer>?
    
    //MARK: UI Elements
    private let calendarImage = UIImageView(image: .calendarIcon)
    private let genreImage = UIImageView(image: .filmIcon)
    
    private lazy var strokeView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.primaryGray.cgColor
        return view
    }()
    
    private lazy var movieNavigationBar: MovieNavigationBar = {
        let navigationBar = MovieNavigationBar(title: Constant.movieList, stateHeartButton: true)
        navigationBar.navigationController = self.navigationController
        return navigationBar
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var trailerView: YTPlayerView = {
        let view = YTPlayerView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var movieStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    private lazy var descriptionStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    private lazy var nameMovie: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 16)
        label.text = "Batman"
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = UIFont.montserratMedium(size: 14)
        label.text = "Release Date: March 2, 2022"
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryGray
        label.font = UIFont.montserratMedium(size: 14)
        label.text = "Action"
        return label
    }()
    
    private lazy var synopsisLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratBold(size: 16)
        label.text = "Synopsis"
        return label
    }()
    
    private lazy var descriprionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.montserratRegular(size: 14)
        label.numberOfLines = 0
        label.text = "THE BATMAN is an edgy, action-packed thriller that depicts Batman in his early years, struggling to balance rage with righteousness as he investigates a disturbing mystery that has terrorized Gotham. Robert Pattinson delivers a raw, intense portrayal of Batman as a disillusioned, desperate vigilante awakened by the realization.. MoreTHE BATMAN is an edgy, action-packed thriller that depicts Batman in his early years, struggling to balance rage with righteousness as he investigates a disturbing mystery that has terrorized Gotham. Robert Pattinson delivers a raw, intense portrayal of Batman as a disillusioned, desperate vigilante awakened by the realization.. MoreTHE BATMAN is an edgy, action-packed thriller that depicts Batman in his early years, struggling to balance rage with righteousness as he investigates a disturbing mystery that has terrorized Gotham. Robert Pattinson delivers a raw, intense portrayal of Batman as a disillusioned, desperate vigilante awakened by the realization.. More"
        return label
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureCollectionView()
        createDataSource()
        applySnapshot()
        loadTrailer()
        
    }
    
    //MARK: Setup UI
    private func setupViews() {
        view.backgroundColor = .primaryDark
        
        movieStackView.addArrangedSubview(calendarImage)
        movieStackView.addArrangedSubview(dateLabel)
        movieStackView.addArrangedSubview(strokeView)
        movieStackView.addArrangedSubview(genreImage)
        movieStackView.addArrangedSubview(genreLabel)
        
        descriptionStackView.addArrangedSubview(synopsisLabel)
        descriptionStackView.addArrangedSubview(descriprionLabel)
        
        scrollView.addSubview(trailerView)
        scrollView.addSubview(nameMovie)
        scrollView.addSubview(movieStackView)
        scrollView.addSubview(descriptionStackView)
        
        view.addSubview(movieNavigationBar)
        view.addSubview(scrollView)
        
        movieNavigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(45)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(movieNavigationBar.snp.bottom)
            make.width.equalTo(view.frame.width)
            make.height.equalTo(view.frame.height / 2)
        }

        trailerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.horizontalEdges.equalTo(view.snp.horizontalEdges).inset(24)
            make.height.equalTo(view.frame.height / 4)
        }
        
        nameMovie.snp.makeConstraints { make in
            make.top.equalTo(trailerView.snp.bottom).inset(-12)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
            
        movieStackView.snp.makeConstraints { make in
            make.top.equalTo(nameMovie.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(40)
        }
        
        descriptionStackView.snp.makeConstraints { make in
            make.top.equalTo(movieStackView.snp.bottom).inset(-8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    //MARK: - Display network error
    private func alertError(_ error: String) {
        let alert = UIAlertController(title: Constant.requestError, message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: Constant.ok, style: .destructive)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: Load trailer
    private func loadTrailer() {
        guard let id = presenter?.makeTrailerId() else { return }
        trailerView.load(withVideoId: id)
    }
}


//MARK: - Extension Set CollactionView
extension TrailerViewController {
    
    //MARK: Create Laouyt
    func createLayout() -> UICollectionViewLayout {
        let sectionProvider = {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = SectionTrailer(rawValue: sectionIndex) else { return nil }
            
            let section: NSCollectionLayoutSection
            
            if sectionKind == .person {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 5
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                section.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
                
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
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView?.snp.makeConstraints({ make in
            make.top.equalTo(scrollView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(90)
        })
    }
    
    //MARK: Regisration
    func registrationPerson() -> UICollectionView.CellRegistration<TrailerCell, Person> {
        return UICollectionView.CellRegistration<TrailerCell, Person> { cell, indexPath, person in
            cell.configure(person: person)
        }
    }

    func registrationHeader() -> UICollectionView.SupplementaryRegistration<TrailerHeader> {
        return UICollectionView.SupplementaryRegistration<TrailerHeader> (elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.configure(Constant.castAndCrew)
        }
    }
    
    //MARK: Create dataSource
    func createDataSource() {
        let registrationPerson = registrationPerson()
        let registrationHeader = registrationHeader()
        
        dataSource = UICollectionViewDiffableDataSource<SectionTrailer, ItemTrailer>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let sectionKind = SectionTrailer(rawValue: indexPath.section) else { return nil }
            
            switch sectionKind {
            case .person:
                return collectionView.dequeueConfiguredReusableCell(using: registrationPerson, for: indexPath, item: item.person)

            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                if let sectionKind = SectionTrailer(rawValue: indexPath.section) {
                    switch sectionKind {
                    case .person:
                        return collectionView.dequeueConfiguredReusableSupplementary(using: registrationHeader, for: indexPath)
                    }
                }
            }
            return nil
        }
    }
    
    //MARK: applySnapshot
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionTrailer, ItemTrailer>()
        guard let presenter = presenter else { return }
  
        snapshot.appendSections([.person])
        let itemPerson = presenter.getPerson()?.compactMap { ItemTrailer(person: $0) }
        guard let itemPerson = itemPerson else { return }
        snapshot.appendItems(itemPerson, toSection: .person)
            dataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - UICollectionViewDelegate
extension TrailerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.rotueToDetail(at: indexPath)
    }
}


//MARK: - Extension TrailerViewProtocol
extension TrailerViewController: TrailerViewProtocol {
    
    func displayError(_ error: String) {
        Task { alertError(error) }
    }
    
    func updateUI() {
        Task { applySnapshot() }
    }
}
