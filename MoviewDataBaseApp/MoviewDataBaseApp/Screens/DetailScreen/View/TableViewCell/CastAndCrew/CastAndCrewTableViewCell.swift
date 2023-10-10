//
//  CastAndCrewTableViewCell.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import UIKit

class CastAndCrewTableViewCell: UITableViewCell {
    
    static let identifier = "CastAndCrewTableViewCell"

    @IBOutlet weak var castLabel: UILabel!
    
    @IBOutlet weak var releasedDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ movieDetail: MovieDetails) {
        self.castLabel.text = "Actors: \(movieDetail.Actors)"
        self.releasedDate.text = "Released Date: \(movieDetail.Released ?? "")"
    }
}
