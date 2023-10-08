//
//  Presenter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import Foundation

protocol IMoviesDetailViewPresenterInput {
    
}

typealias IMoviesDetailViewPresenterOutput = IMoviesDetailViewControllerInput

final class MoviesDetailViewPresenter {
    // MARK: Properties
    private weak var output: IMoviesDetailViewPresenterOutput?
//    let movieDetails = [MovieDetails]()
//    var listWithSection = [Section<Any>]()
//    var filterdMovieList = [MovieDetails]()
//    var searchFilteredMovies = [MovieDetails]()
//
    init(output: IMoviesDetailViewPresenterOutput) {
        self.output = output
    }
}

extension MoviesDetailViewPresenter: IMoviesDetailViewPresenterInput {
    func presentSearchData(_ movies: [MovieDetails]) {
//        output?.displaySearch(filteredMovies: movies)
    }
    
    
    func presentMoviesData(movieResponse: [MovieDetails]) {
//        let movieDetails = movieResponse
//        output?.displayMovieList(movieDetails: movieDetails)
    }
    
    func updateAllSection(_ movieDetails: [MovieDetails]) {
       
    }
}

