//
//  MoviesDetailViewController.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

protocol IMoviesDetailViewControllerInput: AnyObject {
   
}

protocol IMoviesDetailViewControllerOutput {
    
}


class MoviesDetailViewController: UIViewController {

    var output: IMoviesDetailViewControllerOutput?
    var router: (NSObject & IMoviesDetailViewRoutingLogic & IMoviesDetailDataPassing)?
    var movieData: MovieDetails?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.layer.cornerRadius = 20
            tableView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var movieHeader: CustomHeaderView!
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movieData?.Title
        setupMovieData()
        configure()
        
            
        
    }
    
    func configure() {
        tableView.register(UINib(nibName: DetailInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailInfoTableViewCell.identifier)
        tableView.register(UINib(nibName: RatingViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RatingViewTableViewCell.identifier)
        MoviesDetailConfigurator.configureMoviesView(viewController: self)
        guard let posterURL = URL(string: movieData?.Poster ?? "") else { return }
        movieHeader.moviePoster.load(url: posterURL)
        movieHeader.movieTitle.text = movieData?.Title
        movieHeader.genre.text = movieData?.Genre
    }
    private func setupMovieData() {
        if let movieData  = router?.dataStore.movieDetail {
            self.movieData = movieData
            print(movieData)
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
}

extension MoviesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movieData else { return UITableViewCell() }
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoTableViewCell.identifier, for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
            cell.configure(movie)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingViewTableViewCell.identifier, for: indexPath) as? RatingViewTableViewCell else { return UITableViewCell() }
            let rating = Double(movieData?.imdbRating ?? "0") ?? 0.0
            cell.configure(rating)
            return cell
        case 2:
            return UITableViewCell()
        default:
            return UITableViewCell()
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension MoviesDetailViewController: IMoviesDetailViewControllerInput {
    
}
