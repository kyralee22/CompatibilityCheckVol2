//
//  ReviewTableViewCell.swift
//  P7
//
//  Created by Lucy Xu on 11/2/20.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let reviewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        containerView.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        containerView.layer.cornerRadius = 8
        containerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(containerView)
        
        reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        reviewLabel.font = .systemFont(ofSize: 16)
        reviewLabel.textColor = .black
        reviewLabel.numberOfLines = 0
        containerView.addSubview(reviewLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with review: String) {
        reviewLabel.text = review
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            reviewLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            reviewLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            reviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            reviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
        
    }
    
}
