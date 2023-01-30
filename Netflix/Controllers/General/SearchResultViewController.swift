//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 30/01/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultViewControllerDidTapItem(_ viewModel: FilmPreviewViewModel)
}

class SearchResultViewController: UIViewController {

    public var films: [Film] = [Film]()
    
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    public let searchResultCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier, for: indexPath) as? FilmCollectionViewCell else { return UICollectionViewCell()}
        
        let film = films[indexPath.item]
        
        cell.configure(with: film.poster_path ?? "")
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let film = films[indexPath.item]
        let filmName = film.original_name ?? film.original_title ?? ""
        
        APICaller.shared.getMovie(with: filmName) { [weak self] result in
            switch result {
            case .success(let videoItem):
                self?.delegate?.searchResultViewControllerDidTapItem(FilmPreviewViewModel(title: filmName, youtubeVideo: videoItem, filmOverview: film.overview ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
