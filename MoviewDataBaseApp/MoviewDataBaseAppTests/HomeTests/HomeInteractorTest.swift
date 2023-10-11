//
//  HomeInteractor.swift
//  MoviewDataBaseAppTests
//
//  Created by Venky on 10/10/23.
//

import XCTest

@testable import MoviewDataBaseApp

final class HomeInteractor: XCTestCase {
    
    private var interactor: MoviesViewInteractor?
    private var worker: HomeWorkerSpy?
    private var presenter: HomePresenterSpy?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        worker = HomeWorkerSpy()
        presenter = HomePresenterSpy()
        interactor = MoviesViewInteractor(with: MoviesViewInteractor.Dependency(worker: worker, output: presenter))
        
    }
    func testFetchDataAtMethodCallShouldCallPresentOnResponse() {
        XCTAssertEqual(worker?.didCallFetchData, false)
        interactor?.fetchMoviesData()
        XCTAssertEqual(worker?.didCallFetchData, true)
    }
    
    func testFetchDataAtMethodCallShouldCallPresentSearchData() {
        XCTAssertEqual(presenter?.didpresentSearchData, false)
        let mockResponse = [MovieDetails(Title: "")]
        interactor?.fetchSearchData(mockResponse, query: "")
        XCTAssertEqual(presenter?.didpresentSearchData, true)
      
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        worker = nil
        presenter = nil
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

private final class HomePresenterSpy: IMoviesViewPresenterInput {
    
    
    private(set) var didpresentMoviesData = false
    private(set) var didupdateAllSection = false
    private(set) var didpresentSearchData = false
    private(set) var didGetSectionWiseData = false
    
    
    func presentMoviesData(movieResponse: [MoviewDataBaseApp.MovieDetails]) {
        didpresentMoviesData = true
    }
    
    func updateAllSection(_ movieDetails: [MoviewDataBaseApp.MovieDetails]) {
        didupdateAllSection = true
    }
    
    func presentSearchData(_ movies: [MoviewDataBaseApp.MovieDetails]) {
        didpresentSearchData = true
    }
    func getSectionWiseData(movieDetails: [MoviewDataBaseApp.MovieDetails]) {
        didGetSectionWiseData  = true
    }
}

private final class HomeWorkerSpy: IMoviesViewWorker {
    
    
    private(set) var didCallFetchData = false
    
    func fetchMovieDetails(urlString: String, completion: @escaping (Result<[MoviewDataBaseApp.MovieDetails], MoviewDataBaseApp.DataError>) -> Void) {
        didCallFetchData = true
    }
}
