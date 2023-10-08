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
        var output: IMoviesDetailViewInteractorOutput?
    }
    
    // MARK: - Properties
    private var output: IMoviesDetailViewInteractorOutput?
    
    init(with dependency: Dependency) {
        output = dependency.output
    }
}
// MARK: - Interactor Input
extension MoviesDetailViewInteractor: IMoviesDetailViewInteractorInput {

}


