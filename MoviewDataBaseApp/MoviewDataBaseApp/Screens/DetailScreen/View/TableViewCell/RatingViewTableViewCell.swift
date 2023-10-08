//
//  RatingViewTableViewCell.swift
//  MoviewDataBaseApp
//
//  Created by Venky on 08/10/23.
//

import UIKit

class RatingViewTableViewCell: UITableViewCell {
    static let identifier = "RatingViewTableViewCell"
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16 // Adjust the spacing as needed
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "IMDB Rating"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
   
    let ratingView: RatingView = {
        let rating = RatingView()
        
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ rating: Double) {
        ratingView.rating = Int(rating)
        stackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(ratingView)
        
        
        contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)
        ])
    }
    

}
class RatingView: UIView {
    private let starImageViews: [UIImageView] = {
        var imageViews = [UIImageView]()
        for _ in 0..<10 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.image = UIImage(named: "star_empty") // You can use your own star image
            imageViews.append(imageView)
        }
        return imageViews
    }()

    var rating: Int = 0 {
        didSet {
            updateRating()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }

    private func setupUI() {
        for (index, starImageView) in starImageViews.enumerated() {
            addSubview(starImageView)
            NSLayoutConstraint.activate([
                starImageView.widthAnchor.constraint(equalToConstant: 20),
                starImageView.heightAnchor.constraint(equalToConstant: 20),
                starImageView.topAnchor.constraint(equalTo: topAnchor),
                starImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(index * 30))
            ])
        }
    }

    private func updateRating() {
        for (index, starImageView) in starImageViews.enumerated() {
            let imageName = index < rating ? "star_filled" : "star_empty"
            starImageView.image = UIImage(named: imageName)
        }
    }
}


   
    

