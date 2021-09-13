//
//  GroupCollectionViewCell.swift
//  compatibility
//
//  Created by Kyra Lee on 2/1/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    
    var resources: Resources = Resources()
    var group: Group!
    var name: UILabel!
    var overall: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = resources.darkRed
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "\(group.groupName ?? "group"): "
        name.textColor = resources.lightRed
        name.font = resources.numbersFont.withSize(35)
        name.textAlignment = .center
        contentView.addSubview(name)
        
        overall = UILabel()
        overall.translatesAutoresizingMaskIntoConstraints = false
        overall.text = "\(String(group.overallComp))%"
        overall.textColor = .white // resources.blue
        overall.font = resources.numbersFont.withSize(35)
        overall.textAlignment = .center
        contentView.addSubview(overall)
    }
    
    func setUpConstraints() {
        var widthOfName = name.intrinsicContentSize.width
        if widthOfName > 110 {
            widthOfName = 110
        }
        NSLayoutConstraint.activate([
            name.widthAnchor.constraint(equalToConstant: widthOfName),
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            overall.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: widthOfName + 15),
            overall.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])
    }
    
    func configure(group: Group) {
        self.group = group
        
        setUpViews()
        setUpConstraints()
        
    }
}
