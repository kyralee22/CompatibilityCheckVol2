//
//  RestaurantTableViewCell.swift
//  P7
//
//  Created by Lucy Xu on 10/31/20.
//

import UIKit
import Kingfisher

class RestaurantTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let restaurantImageView = UIImageView()
    private let nameLabel = UILabel()
    private let hoursLabel = UILabel()
    private let ratingLabel = UILabel()
    private let categoriesLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        
        containerView.layer.cornerRadius = 20
        containerView.layer.backgroundColor = UIColor.white.cgColor
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        restaurantImageView.clipsToBounds = true
        restaurantImageView.layer.masksToBounds = true
        restaurantImageView.contentMode = .scaleAspectFill
        containerView.addSubview(restaurantImageView)
        
        nameLabel.textColor = .black
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .boldSystemFont(ofSize: 18)
        containerView.addSubview(nameLabel)
        
        hoursLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.font = .systemFont(ofSize: 12)
        containerView.addSubview(hoursLabel)
        
        ratingLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textAlignment = .right
        ratingLabel.font = .systemFont(ofSize: 12)
        containerView.addSubview(ratingLabel)
        
        categoriesLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        categoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        categoriesLabel.font = .boldSystemFont(ofSize: 12)
        containerView.addSubview(categoriesLabel)
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        let containerPadding: CGFloat = 20
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: containerPadding),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -containerPadding),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: containerPadding),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -containerPadding)
        ])
        
        NSLayoutConstraint.activate([
            restaurantImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            restaurantImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: restaurantImageView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: padding),
            ratingLabel.trailingAnchor.constraint(equalTo: restaurantImageView.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding/2),
            hoursLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            hoursLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoriesLabel.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: padding/2),
            categoriesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoriesLabel.trailingAnchor.constraint(equalTo: hoursLabel.trailingAnchor)
        ])
        
    }
    
    private func getCategoriesText(categories: [String]) -> String {
        return categories.joined(separator: ", ")
    }
    
    func configure(for restaurant: Restaurant) {
        let photoURL = URL(string: restaurant.photo)
        // this downloads the image asynchronously if it's not cached yet
        restaurantImageView.kf.setImage(with: photoURL)
        nameLabel.text = restaurant.name
        hoursLabel.text = "\(restaurant.openTime) - \(restaurant.closeTime)"
        ratingLabel.text = "\(restaurant.rating)/5.0 stars"
        categoriesLabel.text = getCategoriesText(categories: restaurant.category)
    }
    
}
