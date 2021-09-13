//
//  ParticipantCollectionViewCell.swift
//  compatibility
//
//  Created by Kyra Lee on 2/16/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class ParticipantCollectionViewCell: UICollectionViewCell {
    // cell with participant names (and symbols)
    let resources: Resources = Resources()
    
    var name: UILabel!
    var horo: UIImageView!
    var myers: UIImageView!
    var ennea: UIImageView!
    
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
        name.textAlignment = .center
        name.font = resources.numbersFont.withSize(20)
        
        horo = UIImageView()
        myers = UIImageView()
        ennea = UIImageView()
    }
    
    func setUpConstraints() {
        
    }
    
    func configure(name: String, horo: String, myers: String, ennea: String) {
        self.name.text = name
        self.horo.image = UIImage(named: horo)
        self.myers.image = UIImage(named: myers)
        self.ennea.image = UIImage(named: ennea)
    }
}
