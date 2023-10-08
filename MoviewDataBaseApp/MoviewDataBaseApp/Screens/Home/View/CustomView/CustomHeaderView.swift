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
        }
    }
    
    @IBOutlet weak var genre: UILabel!
    
    
    
   
    

}
