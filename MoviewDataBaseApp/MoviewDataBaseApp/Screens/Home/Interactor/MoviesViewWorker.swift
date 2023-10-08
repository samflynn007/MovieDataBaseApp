//
//  MoviesViewWorker.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

import Foundation

typealias Handler<T> = (Result<T, DataError>) -> Void

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

protocol IMoviesViewWorker {
    func fetchMovieDetails(urlString: String, completion: @escaping (Result<[MovieDetails], DataError>) -> Void)
}

final class MoviesViewWorker: IMoviesViewWorker {
    func fetchMovieDetails(urlString: String, completion: @escaping (Result<[MovieDetails], DataError>)-> Void){
        
        guard let url = Bundle.main.url(forResource: urlString, withExtension: "json") else {
            completion(.failure(.invalidURL))
            return
        }
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([MovieDetails].self, from: data)
                completion(.success(jsonData))
            }catch {
                completion(.failure(.network(error)))
            }
    }
}

