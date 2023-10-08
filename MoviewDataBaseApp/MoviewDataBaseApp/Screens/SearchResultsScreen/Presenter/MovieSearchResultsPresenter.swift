//
//  MovieSearchResultsPresenter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import Foundation

protocol ISearchResultsPresenterInput {
    
}


typealias ISearchResultsPresenterOutput = ISearchResultsViewControllerInput

final class SearchResultsViewPresenter {
    // MARK: Properties
    private weak var output: ISearchResultsPresenterOutput?
    let movieDetails = [MovieDetails]()
    var listWithSection = [Section<Any>]()
    var filterdMovieList = [MovieDetails]()
    var searchFilteredMovies = [MovieDetails]()
    
    init(output: ISearchResultsPresenterOutput) {
        self.output = output
    }
}

extension SearchResultsViewPresenter: ISearchResultsPresenterInput {
    
}


