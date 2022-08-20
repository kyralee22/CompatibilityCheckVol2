//
//  RestaurantModalViewController.swift
//  where2eat
//
//  Created by Kyra Lee on 5/25/22.
//  Copyright © 2022 Kyra Lee. All rights reserved.
//

import UIKit

class RestaurantModalViewController: UIViewController {
    
    var type : String!
    var places : [String : [String]] = [:]
    
    var optionTitle : UILabel!
    var labels : [UILabel] = []
    
    init(type: String){
        super.init(nibName: nil, bundle: nil)
        self.type = type
        
        places["chinese"] = ["de tasty hotpot", "fusia", "asian chili spot"]
        places["korean"] = ["masita", "four seasons", "gangnam station", "so poong", "kokos"]
        places["greek"] = ["souvlaki house"]
        places["american"] = ["subway", "lunas", "wings over", "jacks", "CTB", "evan burger"]
        places["mexican"] = ["old mexico", "dos amigos"]
        places["japanese"] = ["plumtree", "oishii"]
        places["italian"] = ["DP dough", "CTP", "enzo pizzeria", "mama teresa's pizzeria", "pronto"]
        places["misc"] = ["poke", "mango mango", "pronto", "mehak indian", "doordash", "pho"]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setUpViews()
        setUpConstraints()
        
    }
   
    func setUpViews() {
        optionTitle = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        optionTitle.translatesAutoresizingMaskIntoConstraints = false
        optionTitle.font = UIFont.boldSystemFont(ofSize: 30)
        optionTitle.text = type + " options"
        optionTitle.textAlignment = .center
        let gradient = getGradientLayer(bounds: optionTitle.bounds)
        optionTitle.textColor = gradientColor(bounds: optionTitle.bounds, gradientLayer: gradient)
        view.addSubview(optionTitle)
        
        for place in places[type]! {
            let temp = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
            temp.translatesAutoresizingMaskIntoConstraints = false
            temp.font = UIFont.boldSystemFont(ofSize: 23)
            temp.text = place
            temp.textAlignment = .center
            temp.textColor = .white
            view.addSubview(temp)
            labels.append(temp)
        }
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
                   optionTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                   optionTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 4)
               ])
               
               var space = 30
               
               for label in labels {
                   NSLayoutConstraint.activate([
                       label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                       label.topAnchor.constraint(equalTo: optionTitle.bottomAnchor, constant: CGFloat(space)),
                       label.widthAnchor.constraint(equalToConstant: 200)
                   ])
                   
                   space = space + 50
               }
        
    }
}
