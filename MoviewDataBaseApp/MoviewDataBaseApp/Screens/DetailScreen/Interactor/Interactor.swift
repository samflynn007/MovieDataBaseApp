//
//  Interactor.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import Foundation

typealias IMoviesDetailViewInteractorInput  = IMoviesDetailViewControllerOutput
typealias IMoviesDetailViewInteractorOutput = IMoviesDetailViewPresenterInput

final class MoviesDetailViewInteractor {
    struct Dependency {
        var worker: IMoviesDetailViewWorker?
        var output: IMoviesDetailViewInteractorOutput?
    }
    
    // MARK: - Properties
    private var worker: IMoviesDetailViewWorker?
    private var output: IMoviesDetailViewInteractorOutput?
    
    init(with dependency: Dependency) {
        worker = dependency.worker
        output = dependency.output
    }
}
// MARK: - Interactor Input
extension MoviesDetailViewInteractor: IMoviesDetailViewInteractorInput {
    func fetchSectionData() {
       
    }
    
    
    func fetchMoviesData() {
        
    }
    
    func fetchSearchData(_ movies: [MovieDetails], query: String) {
        
    }

    
}


