//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: FilmPreviewViewModel)
}


class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifier = "CollectionViewTableViewCell"
    private var films: [Film] = [Film]()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: FilmCollectionViewCell.identifier)
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with films: [Film]) {
        self.films = films
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension CollectionViewTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
}


extension CollectionViewTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.identifier, for: indexPath) as? FilmCollectionViewCell else { return UICollectionViewCell()}
        
        guard let model = films[indexPath.row].poster_path else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        let film = films[indexPath.row]
        guard let filmName = film.original_name ?? film.original_title else { return }
        
        
        APICaller.shared.getMovie(with: filmName + " trailer") { [weak self] result in
            switch result{
            case .success(let videoItem):
                let film = self?.films[indexPath.row]
                guard let filmOverview = film?.overview else { return }
                let viewModel = FilmPreviewViewModel(title: filmName, youtubeVideo: videoItem, filmOverview: filmOverview)
                
                guard let strongSelf = self else { return }
                
                self?.delegate?.collectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil) { _ in
                let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                    print("Download tapped")
                }
                
                return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
            }
        return config
    }
    

}


