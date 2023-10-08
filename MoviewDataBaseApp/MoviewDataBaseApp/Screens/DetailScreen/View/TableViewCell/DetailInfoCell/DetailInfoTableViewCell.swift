//
//  DetailInfoTableViewCell.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

class DetailInfoTableViewCell: UITableViewCell {
    
    static let identifier  = "DetailInfoTableViewCell"

    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var RunTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ movieDetail: MovieDetails) {
        self.movieOverview.text = "\(movieDetail.Plot ?? "")"
        self.RunTime.text = "RunTime:\(movieDetail.Runtime ?? "")"
    }
    
}
