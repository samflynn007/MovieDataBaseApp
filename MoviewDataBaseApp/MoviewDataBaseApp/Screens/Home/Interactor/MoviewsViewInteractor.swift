//
//  MoviewsViewInteractor.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

import Foundation

typealias IMoviesViewInteractorInput  = IMoviesViewControllerOutput
typealias IMoviesViewInteractorOutput = IMoviesViewPresenterInput

final class MoviesViewInteractor {
    struct Dependency {
        var worker: IMoviesViewWorker?
        var output: IMoviesViewInteractorOutput?
    }
    
    // MARK: - Properties
    private var worker: IMoviesViewWorker?
    private var output: IMoviesViewInteractorOutput?
    
    init(with dependency: Dependency) {
        worker = dependency.worker
        output = dependency.output
    }
}
// MARK: - Interactor Input
extension MoviesViewInteractor: IMoviesViewInteractorInput {
    func fetchSectionData() {
        
    }
    
    
    func fetchMoviesData() {
        worker?.fetchMovieDetails(urlString: "movies", completion: { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.output?.presentMoviesData(movieResponse: movieDetails)
                self?.output?.updateAllSection(movieDetails)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func fetchSearchData(_ movies: [MovieDetails], query: String) {
        var filteredMovies = movies.filter { movie in
            return movie.Title.lowercased().contains(query.lowercased()) ||
            movie.Genre.lowercased().contains(query.lowercased()) ||
            movie.Director.lowercased().contains(query.lowercased()) ||
            movie.Actors.lowercased().contains(query.lowercased())
            
        }
        output?.presentSearchData(filteredMovies)
    }

    
}

