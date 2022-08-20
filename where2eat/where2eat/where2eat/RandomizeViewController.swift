//
//  RandomizeViewController.swift
//  where2eat
//
//  Created by Kyra Lee on 5/25/22.
//  Copyright © 2022 Kyra Lee. All rights reserved.
//

import UIKit

class RandomizeViewController: UIViewController {
    var weChoose : UILabel!
    var pickOne : UIButton!
    var allPlaces : [String]!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        allPlaces = ["de tasty hotpot", "fusia", "asian chili spot", "masita", "four seasons", "gangnam station", "so poong", "kokos", "souvlaki house", "subway", "lunas", "wings over", "jacks", "CTB", "evan burger", "old mexico", "dos amigos", "plumtree", "oishii", "DP dough", "CTP", "enzo pizzeria", "mama teresa's pizzeria", "pronto", "poke", "mango mango", "pronto", "mehak indian", "doordash", "pho"]
        
        setUpViews()
        setUpConstraints()

    }
    
    @objc func randomPick(_ sender : UIButton) {
        // get random index value
        var ind = 0
        let temp = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.font = UIFont.boldSystemFont(ofSize: 23)
        temp.text = allPlaces[ind]
        temp.textAlignment = .center
        temp.textColor = .white
        view.addSubview(temp)
        
        NSLayoutConstraint.activate([
            temp.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            temp.topAnchor.constraint(equalTo: pickOne.bottomAnchor, constant: 40)
        ])
    }
    
    func setUpViews() {
        weChoose = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        weChoose.translatesAutoresizingMaskIntoConstraints = false
        weChoose.font = UIFont.boldSystemFont(ofSize: 30)
        weChoose.text = "alright, we'll pick"
        weChoose.textAlignment = .center
        let gradient = getGradientLayer(bounds: weChoose.bounds)
        weChoose.textColor = gradientColor(bounds: weChoose.bounds, gradientLayer: gradient)
        view.addSubview(weChoose)
        
        pickOne = UIButton(frame: view.bounds)
        pickOne.translatesAutoresizingMaskIntoConstraints = false
        pickOne.setTitle("pick for me", for: .normal)
        pickOne.setTitleColor(.black, for: .normal)
        pickOne.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        pickOne.layer.cornerRadius = 8
        pickOne.backgroundColor = .white
        pickOne.layer.shadowColor = UIColor.white.cgColor
        pickOne.layer.shadowOpacity = 0.7
        pickOne.layer.borderWidth = 2
        pickOne.layer.borderColor = UIColor.white.cgColor
        pickOne.addTarget(self, action: #selector(randomPick(_:)), for: .touchUpInside)
        view.addSubview(pickOne)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
                   weChoose.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                   weChoose.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 4)
               ])
        NSLayoutConstraint.activate([
            pickOne.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pickOne.topAnchor.constraint(equalTo: weChoose.bottomAnchor, constant: 30),
            pickOne.widthAnchor.constraint(equalToConstant: 120)
        ])
        
    }

}
