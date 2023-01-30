//
//  FilmTableViewCell.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 30/01/23.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    static let identifier = "FilmTableViewCell"
    
    private let filmPosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let filmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playFilmButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(filmPosterImageView)
        contentView.addSubview(filmLabel)
        contentView.addSubview(playFilmButton)
        
        applyConstraint()
    }
    
    private func applyConstraint(){
        let filmPosterImageViewConstraints = [
            filmPosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filmPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            filmPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            filmPosterImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let filmLabelConstraints = [
            filmLabel.leadingAnchor.constraint(equalTo: filmPosterImageView.trailingAnchor, constant: 20),
            filmLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let playFilmButtonConstraints = [
            playFilmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playFilmButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(playFilmButtonConstraints)
        NSLayoutConstraint.activate(filmPosterImageViewConstraints)
        NSLayoutConstraint.activate(filmLabelConstraints)
    }
    
    func configure(with model: FilmViewModel){

        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        
        filmPosterImageView.sd_setImage(with: url, completed: nil)
        filmLabel.text = model.filmName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
