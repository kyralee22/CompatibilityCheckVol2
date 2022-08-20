//
//  ReviewViewController.swift
//  P7
//
//  Created by Lucy Xu on 11/2/20.
//

import UIKit

class ReviewViewController: UIViewController {
    
    private let reviewsTableView = UITableView()
    private let reviewsTableViewReuseIdentifier = "ReviewsTableViewReuseIdentifier"
    private var reviews: [String] = []
    
    init(reviews: [String]) {
        super.init(nibName: nil, bundle: nil)
        self.reviews = reviews
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        reviewsTableView.delegate = self
        reviewsTableView.dataSource = self
        reviewsTableView.rowHeight = UITableView.automaticDimension
        reviewsTableView.estimatedRowHeight = UITableView.automaticDimension
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        reviewsTableView.separatorStyle = .none
        reviewsTableView.register(ReviewTableViewCell.self, forCellReuseIdentifier: reviewsTableViewReuseIdentifier)
        view.addSubview(reviewsTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            reviewsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            reviewsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            reviewsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding/2),
            reviewsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding/2)
        ])
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reviewsTableViewReuseIdentifier, for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        let review = reviews[indexPath.row]
        cell.configure(with: review)
        return cell
    }
}

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



