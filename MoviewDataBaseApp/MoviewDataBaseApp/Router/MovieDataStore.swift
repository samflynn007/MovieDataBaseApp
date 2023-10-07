//
//  MovieDataStore.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 06/10/23.
//

protocol IMovieDataStore {
    var movieDetail: MovieDetails? { get set }
    var movieDetails: [MovieDetails]? { get set }
    
}

final class DefaultMovieDataStore: IMovieDataStore {
    var movieDetail: MovieDetails?
    var movieDetails: [MovieDetails]? 
}
