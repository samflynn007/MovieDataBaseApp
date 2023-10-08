//
//  MoviesDetailDataStore.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

protocol IMovieDetailDataStore {
    var movieDetail: MovieDetails? { get set }
    
    
}

final class DefaultMovieDetailDataStore: IMovieDetailDataStore {
    var movieDetail: MovieDetails?
}

