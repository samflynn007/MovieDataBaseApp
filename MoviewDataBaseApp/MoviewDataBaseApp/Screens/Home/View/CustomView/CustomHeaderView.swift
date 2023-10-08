//
//  CustomHeaderView.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 07/10/23.
//

import UIKit

class CustomHeaderView: UIView {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel! {
        didSet {
            movieTitle.numberOfLines = 0
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                movieTitle.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    
    @IBOutlet weak var genre: UILabel! {
        didSet {
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                genre.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
        }
    }
    
    
    
   
    

}
