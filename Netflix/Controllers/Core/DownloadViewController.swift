//
//  DownloadViewController.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 29/01/23.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var films : [FilmItem] = [FilmItem]()
    
    private let downloadTable : UITableView = {
        let table = UITableView()
        table.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        title = "Download"
        
        view.addSubview(downloadTable)
        
        
        downloadTable.delegate = self
        downloadTable.dataSource = self
        
        fetchLocalFilm()
    }
    
    private func fetchLocalFilm(){
        DataPersistenceManager.shared.fetchFilmFromDatabase { [weak self] result in
            switch result{
            case .success(let films):
                self?.films = films
                DispatchQueue.main.async {
                    self?.downloadTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
}


extension DownloadViewController: UITableViewDelegate, UITableViewDataSource{
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.shared.deleteFilm(model: films[indexPath.row]) { [weak self] result in
                switch(result){
                case .success():
                    print("Delete success")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.films.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
               
            }
        default:
            break
        }
    }
}
