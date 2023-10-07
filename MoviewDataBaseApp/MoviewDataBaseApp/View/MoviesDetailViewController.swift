//
//  MoviesDetailViewController.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

class MoviesDetailViewController: UIViewController {

    var output: IMoviesViewControllerOutput?
    var router: (IMoviesViewRoutingLogic & IMoviesDataPassing)?
    var movieDetail: MovieDetails?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var movieHeader: CustomHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        tableView.register(UINib(nibName: "DetailInfoTableViewCell", bundle: nil), forCellReuseIdentifier: DetailInfoTableViewCell.identifier)
        
    }
    
    func configure() {
        movieHeader.moviePoster.load(url: URL(string: movieDetail?.Poster ?? "")!)
        movieHeader.movieTitle.text = movieDetail?.Title
        movieHeader.genre.text = movieDetail?.Genre
    }
}

extension MoviesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movieDetail else { return UITableViewCell() }
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoTableViewCell.identifier, for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
            cell.configure(movie)
            
            return cell
        case 1:
            return UITableViewCell()
        case 2:
            return UITableViewCell()
        default:
            return UITableViewCell()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
