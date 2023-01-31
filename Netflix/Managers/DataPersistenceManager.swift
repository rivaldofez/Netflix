//
//  DataPersistenceManager.swift
//  Netflix
//
//  Created by Rivaldo Fernandes on 31/01/23.
//

import UIKit
import CoreData



class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadFilm(model: Film, completion: @escaping (Result<Void, Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let item = FilmItem(context: context)
        
        item.original_title = model.original_title
        item.original_name = model.original_name
        item.overview = model.overview
        item.poster_path = model.poster_path
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.vote_average = model.vote_average
        item.vote_count = Int64(model.vote_count)
        item.release_date = model.release_data
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToSaveData))
        }
    }
    
    
    func fetchFilmFromDatabase(completion: @escaping (Result<[FilmItem], Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<FilmItem>
        
        request = FilmItem.fetchRequest()
        
        do {
            let films = try context.fetch(request)
            completion(.success(films))
        } catch {
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteFilm(model: FilmItem, completion: @escaping (Result<Void, Error>)-> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
