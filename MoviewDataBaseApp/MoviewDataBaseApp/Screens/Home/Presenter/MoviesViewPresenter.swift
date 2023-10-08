//
//  MoviesViewPresenter.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

import Foundation

protocol IMoviesViewPresenterInput {
    func presentMoviesData(movieResponse: [MovieDetails])
    func updateAllSection(_ movieDetails: [MovieDetails])
    func presentSearchData(_ movies: [MovieDetails])
}

typealias IMoviesViewPresenterOutput = IMoviesViewControllerInput

final class MoviesViewPresenter {
    // MARK: Properties
    private weak var output: IMoviesViewPresenterOutput?
    let movieDetails = [MovieDetails]()
    var listWithSection = [Section<Any>]()
    var filterdMovieList = [MovieDetails]()
    var searchFilteredMovies = [MovieDetails]()
    
    init(output: IMoviesViewPresenterOutput) {
        self.output = output
    }
}

extension MoviesViewPresenter: IMoviesViewPresenterInput {
    func presentSearchData(_ movies: [MovieDetails]) {
        output?.displaySearch(filteredMovies: movies)
    }
    
    
    func presentMoviesData(movieResponse: [MovieDetails]) {
        let movieDetails = movieResponse
        output?.displayMovieList(movieDetails: movieDetails)
    }
    
    func updateAllSection(_ movieDetails: [MovieDetails]) {
        let yearArray = Set(movieDetails.map { $0.Year })
        let genreArray = Set(movieDetails.map { $0.Genre })
        let actors =  Set(movieDetails.map { $0.Actors })
        let directors = Set(movieDetails.map { $0.Director })
        let allMovies = movieDetails
     
        let genresArray = Array(genreArray).sorted()
        let splitGenres = genresArray.flatMap { $0.components(separatedBy: ", ") }
        
        let actorsArray = Array(actors).sorted()
        let splitActors = actorsArray.flatMap { $0.components(separatedBy: ", ") }
        
        let directorsArray = Array(directors).sorted()
        let splitDirectors = directorsArray.flatMap { $0.components(separatedBy: ", ") }

        var movieDatabaseList = [Section<Any>]()
        movieDatabaseList.append(Section(title:  "Year", expanded: false, listData: yearArray.sorted()))
        movieDatabaseList.append(Section(title: "Genre", expanded: false, listData: splitGenres))
        movieDatabaseList.append(Section(title: "Directors", expanded: false, listData: splitDirectors))
        movieDatabaseList.append(Section(title: "Actors", expanded: false, listData: splitActors))
        movieDatabaseList.append(Section(title: "All Movies", expanded: false, listData: allMovies))
        output?.displaySectionList(sectionMoview: movieDatabaseList)
    }
}

