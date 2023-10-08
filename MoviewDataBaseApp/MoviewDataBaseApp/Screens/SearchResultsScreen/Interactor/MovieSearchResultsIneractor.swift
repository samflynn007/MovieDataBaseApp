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
        var output: ISearchResultsViewInteractorOutput?
    }
    
    // MARK: - Properties
    private var output: ISearchResultsViewInteractorOutput?
    
    init(with dependency: Dependency) {
        output = dependency.output
    }
}
// MARK: - Interactor Input
extension SearchResultsViewInteractor: ISearchResultsViewInteractorInput {
  

    
}


