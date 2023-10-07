//
//  AllMoviesTableViewCell.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

class AllMoviesTableViewCell: UITableViewCell {
    

    @IBOutlet weak var posterImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var languageLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    
    static let identifier = "AllMoviesTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(movieDetail: MovieDetails) {
        self.movieTitle.text = movieDetail.Title
        self.posterImage.load(url: URL(string: movieDetail.Poster ?? "")!)
        self.languageLabel.text = "Language: \(movieDetail.Language ?? "")"
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
