//
//  MovieSearchResultsIneractor.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

typealias ISearchResultsViewInteractorInput  = ISearchResultsViewControllerOutput
typealias ISearchResultsViewInteractorOutput = ISearchResultsPresenterInput

final class SearchResultsViewInteractor {
    struct Dependency {
//        var worker: IMoviesViewWorker?
        var output: ISearchResultsViewInteractorOutput?
    }
    
    // MARK: - Properties
//    private var worker: IMoviesViewWorker?
    private var output: ISearchResultsViewInteractorOutput?
    
    init(with dependency: Dependency) {
//        worker = dependency.worker
        output = dependency.output
    }
}
// MARK: - Interactor Input
extension SearchResultsViewInteractor: ISearchResultsViewInteractorInput {
  

    
}


