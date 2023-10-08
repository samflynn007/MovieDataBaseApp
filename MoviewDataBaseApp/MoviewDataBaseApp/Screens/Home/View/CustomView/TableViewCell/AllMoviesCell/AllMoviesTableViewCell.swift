//
//  AllMoviesTableViewCell.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

class AllMoviesTableViewCell: UITableViewCell {
    

    @IBOutlet weak var posterImage: UIImageView! {
        didSet {
            posterImage.layer.cornerRadius = 10.0
            posterImage.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    static let identifier = "AllMoviesTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movieDetail: MovieDetails) {
        self.movieTitle.text = movieDetail.Title
        guard let urlStr = URL(string: movieDetail.Poster ?? CommonConstant.emptyString) else { return }
        self.posterImage.load(url: urlStr)
        self.languageLabel.text = "Language: \(movieDetail.Language ?? CommonConstant.emptyString)"
        self.yearLabel.text = "Year: \(movieDetail.Year)"
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
