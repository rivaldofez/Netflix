//
//  UpcomingViewController.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var films : [Film] = [Film]()
    
    private let upcomingTable : UITableView = {
        let table = UITableView()
        table.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Upcoming"
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming(){
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let films):
                self?.films = films
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.identifier, for: indexPath) as? FilmTableViewCell else { return UITableViewCell()}
        
        let film = films[indexPath.row]
        
        cell.configure(with: FilmViewModel(filmName: (film.original_name ?? film.original_title) ?? "" , posterURL: film.poster_path ?? ""))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
