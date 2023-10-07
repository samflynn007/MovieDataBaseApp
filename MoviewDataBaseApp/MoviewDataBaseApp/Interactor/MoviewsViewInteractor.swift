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
    
    func fetchSectionData() {
       
    }
    
}

