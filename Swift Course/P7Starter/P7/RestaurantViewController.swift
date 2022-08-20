//
//  ReviewViewController.swift
//  P7
//
//  Created by Lucy Xu on 10/31/20.
//

import UIKit

class RestaurantViewController: UIViewController {
    
    private var restaurant: Restaurant!
    private let restaurantImageView = UIImageView()
    private let nameLabel = UILabel()
    private let hoursLabel = UILabel()
    private let addressLabel = UILabel()
    private let phoneNumberLabel = UILabel()
    private let ratingLabel = UILabel()
    private let reviewTitleLabel = UILabel()
    private let reviewLabel = UILabel()
    private let reviewContainerView = UIView()
    private let seeAllReviewsButton = UIButton()
    
    init(restaurant: Restaurant) {
        super.init(nibName: nil, bundle: nil)
        self.restaurant = restaurant
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        
        let photoURL = URL(string: restaurant.photo)
        // this downloads the image asynchronously if it's not cached yet
        restaurantImageView.kf.setImage(with: photoURL)
        restaurantImageView.translatesAutoresizingMaskIntoConstraints = false
        restaurantImageView.contentMode = .scaleAspectFill
        restaurantImageView.layer.masksToBounds = true
        view.addSubview(restaurantImageView)
        
        nameLabel.text = restaurant.name
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        nameLabel.font = .boldSystemFont(ofSize: 36)
        view.addSubview(nameLabel)
        
        hoursLabel.text = "\(restaurant.openTime) to \(restaurant.closeTime)"
        hoursLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.font = .systemFont(ofSize: 12)
        view.addSubview(hoursLabel)
        
        ratingLabel.text = "\(restaurant.rating)/5.0 stars"
        ratingLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.textAlignment = .right
        ratingLabel.font = .systemFont(ofSize: 12)
        view.addSubview(ratingLabel)
        
        addressLabel.text = restaurant.address
        addressLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.font = .boldSystemFont(ofSize: 12)
        view.addSubview(addressLabel)
        
        phoneNumberLabel.text = restaurant.phoneNumber
        phoneNumberLabel.textColor = UIColor(red: 98/255, green: 98/255, blue: 98/255, alpha: 1)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.font = .boldSystemFont(ofSize: 12)
        view.addSubview(phoneNumberLabel)
        
        reviewTitleLabel.text = "Reviews"
        reviewTitleLabel.font = .boldSystemFont(ofSize: 18)
        reviewTitleLabel.textColor = .black
        reviewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reviewTitleLabel)
        
        reviewContainerView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        reviewContainerView.layer.cornerRadius = 8
        reviewContainerView.sizeToFit()
        reviewContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reviewContainerView)

        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.font = .systemFont(ofSize: 16)
        reviewLabel.textColor = .black
        reviewLabel.numberOfLines = 0
        reviewContainerView.addSubview(reviewLabel)
        
        seeAllReviewsButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllReviewsButton.addTarget(self, action: #selector(seeAllReviews), for: .touchUpInside)
        seeAllReviewsButton.titleLabel?.font = .boldSystemFont(ofSize: 12)
        seeAllReviewsButton.setTitleColor(.black, for: .normal)
        seeAllReviewsButton.setTitle("See All", for: .normal)
        seeAllReviewsButton.contentHorizontalAlignment = .right
        view.addSubview(seeAllReviewsButton)
        
        getRestaurant()
        setupConstraints()
        
    }
    
    @objc func seeAllReviews() {
        if let reviews = restaurant.reviews {
            let reviewViewController = ReviewViewController(reviews: reviews)
            navigationController?.pushViewController(reviewViewController, animated: true)
        }
    }
    
    private func setupConstraints() {
        
        let padding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            restaurantImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            restaurantImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            restaurantImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            restaurantImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: restaurantImageView.bottomAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            hoursLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            hoursLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            hoursLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            ratingLabel.centerYAnchor.constraint(equalTo: hoursLabel.centerYAnchor),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ratingLabel.leadingAnchor.constraint(equalTo: hoursLabel.trailingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: hoursLabel.bottomAnchor, constant: padding/2),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: padding/2),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: addressLabel.leadingAnchor),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: addressLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            reviewTitleLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: padding),
            reviewTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            reviewTitleLabel.trailingAnchor.constraint(equalTo: seeAllReviewsButton.leadingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            seeAllReviewsButton.centerYAnchor.constraint(equalTo: reviewTitleLabel.centerYAnchor),
            seeAllReviewsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            seeAllReviewsButton.leadingAnchor.constraint(equalTo: reviewTitleLabel.trailingAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            reviewContainerView.topAnchor.constraint(equalTo: reviewTitleLabel.bottomAnchor, constant: padding),
            reviewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            reviewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: reviewContainerView.topAnchor, constant: padding),
            reviewLabel.leadingAnchor.constraint(equalTo: reviewContainerView.leadingAnchor, constant: padding),
            reviewLabel.trailingAnchor.constraint(equalTo: reviewContainerView.trailingAnchor, constant: -padding),
            reviewLabel.bottomAnchor.constraint(equalTo: reviewContainerView.bottomAnchor, constant: -padding)
        ])
        
    }
    
    // TODO: Complete function to get restaurant
    private func getRestaurant() {
        NetworkManager.getRestaurant(id: restaurant.id) { restaurant in
            self.restaurant = restaurant
            if let reviews = restaurant.reviews {
                self.reviewLabel.text = reviews[0]
                self.reviewContainerView.sizeToFit()
            }
        }
    }
    
}
