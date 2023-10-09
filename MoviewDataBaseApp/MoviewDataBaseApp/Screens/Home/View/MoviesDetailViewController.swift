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
    private let backButton = UIButton(type: .system)
    
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
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMovieData()
        configureUI()
        navigationSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    private func navigationSetup() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        // button customization
        backButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        backButton.setTitle("Return", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        backButton.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        let backButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backButtonItem
    }
    
    private func configure() {
        MoviesDetailConfigurator.configureMoviesView(viewController: self)
    }
    
    private func configureUI() {
        tableView.register(UINib(nibName: DetailInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DetailInfoTableViewCell.identifier)
        tableView.register(UINib(nibName: RatingViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RatingViewTableViewCell.identifier)
        tableView.register(UINib(nibName: CastAndCrewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CastAndCrewTableViewCell.identifier)
        tableView.register(UINib(nibName: RatingInfoTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: RatingInfoTableViewCell.identifier)
        
        
        guard let posterURL = URL(string: movieData?.Poster ?? CommonConstant.emptyString) else { return }
        movieHeader.moviePoster.load(url: posterURL)
        movieHeader.movieTitle.text = movieData?.Title
        movieHeader.genre.text = movieData?.Genre
    }
    private func setupMovieData() {
        if let movieData  = router?.dataStore.movieDetail {
            self.movieData = movieData
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    @objc private func handleBackButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MoviesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movie = movieData else { return UITableViewCell() }
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoTableViewCell.identifier, for: indexPath) as? DetailInfoTableViewCell else { return UITableViewCell() }
            cell.configure(movie)
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastAndCrewTableViewCell.identifier, for: indexPath) as? CastAndCrewTableViewCell, let movie = movieData else { return UITableViewCell() }
            cell.configure(movie)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingViewTableViewCell.identifier, for: indexPath) as? RatingViewTableViewCell, let ratingDouble = Double(movieData?.imdbRating ?? CommonConstant.emptyString) else { return UITableViewCell() }
            
            cell.configure(ratingDouble)
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RatingInfoTableViewCell.identifier, for: indexPath) as? RatingInfoTableViewCell, let movie = movieData else { return UITableViewCell() }
            
            cell.configure(movie)
            return cell
            
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
    
    @IBAction private func onTapRating(_ sender: UIButton) {
        router?.navigateToRating()
    }
}
