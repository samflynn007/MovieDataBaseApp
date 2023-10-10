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
    
    /// Produce a Movie information  for the given `JSON File`.
    ///
    /// - Parameters:
    ///     - nil.
    ///
    /// - Returns: Movies Details  for the given `JSON File`.
    
    func fetchMoviesData() {
        worker?.fetchMovieDetails(urlString: Home.fileNameString, completion: { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.output?.presentMoviesData(movieResponse: movieDetails)
                self?.output?.updateAllSection(movieDetails)
            case .failure(let error):
                print(error)
            }
        })
    }
    /// Produce a Movie information  for the given `Search String`.
    ///
    /// - Parameters:
    ///     - Movie Details: - Search Movie Matches with  `Input string`   .
    ///      - query: string which input by the `user`
    ///
    /// - Returns: Send Filtered  Data  `[MovieDetails]`.
    
    func fetchSearchData(_ movies: [MovieDetails], query: String) {
        let filteredMovies = movies.filter { movie in
            return movie.Title.lowercased().contains(query.lowercased()) ||
            movie.Genre.lowercased().contains(query.lowercased()) ||
            movie.Director.lowercased().contains(query.lowercased()) ||
            movie.Actors.lowercased().contains(query.lowercased())
            
        }
        output?.presentSearchData(filteredMovies)
    }
    
    /// Produce a Movie information  for the given `Search String`.
    ///
    /// - Parameters:
    ///     - secInd: - take input as indexpath  `IndexPath`   .
    ///     - data:  Section Wise data `[Section<Any>]`
    ///     - movies : Complete Movie data `[MovieDetails]`
    ///
    /// - Returns: Send Section wise Filtered   Data  `[MovieDetails]`.
    
    func getSectionWiseData(secInd: IndexPath, data: [Section<Any>], movies: [MovieDetails])  {
        
        guard let compareValue = data[secInd.section].listData[secInd.row] as? String else { return }
        
        switch secInd.section {
        case 0:
            output?.getSectionWiseData(movieDetails: movies.filter({$0.Year.components(separatedBy: Home.hyphen).contains(compareValue)}))
        case 1:
            output?.getSectionWiseData(movieDetails: movies.filter({$0.Genre.components(separatedBy: Home.comma).contains(compareValue)}))
        case 2:
            output?.getSectionWiseData(movieDetails: movies.filter({$0.Director.components(separatedBy: Home.comma).contains(compareValue)}).sorted())
        case 3:
            output?.getSectionWiseData(movieDetails: movies.filter({$0.Actors.components(separatedBy: Home.comma).contains(compareValue)}))
        default:
            break
        }
    }

    
}


// test cases
// protocol for type
// comments brief
// need to show all movies 
