//
//  pickPlacesViewController.swift
//  where2eat
//
//  Created by Kyra Lee on 5/25/22.
//  Copyright © 2022 Kyra Lee. All rights reserved.
//

import UIKit


class pickPlacesViewController: UIViewController {
    var chosenFoods : [String]!
    
    var clickForOption : UILabel!
    
    var buttons : [UIButton] = []
        
    init(chosenFoods : [String]) {
        super.init(nibName: nil, bundle: nil)
        self.chosenFoods = chosenFoods;
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
    
    @objc func pickedButtons (_ sender: UIButton) {
        let gradient = getGradientLayer(bounds: sender.bounds)
        sender.backgroundColor = gradientColor(bounds: sender.bounds, gradientLayer: gradient)
        sender.setTitleColor(.white, for: .normal)
        
        let restMVC = RestaurantModalViewController(type : sender.title(for: .normal)!)
        present(restMVC, animated: true, completion: nil)
    }
    
    func optionButton(type: String) -> UIButton {
           let temp = UIButton(frame: view.bounds)
           temp.translatesAutoresizingMaskIntoConstraints = false
           temp.setTitle(type, for: .normal)
           temp.setTitleColor(.black, for: .normal)
           temp.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
           temp.layer.cornerRadius = 8
           temp.backgroundColor = .white
           temp.layer.shadowColor = UIColor.white.cgColor
           temp.layer.shadowOpacity = 0.7
           temp.layer.borderWidth = 2
           temp.layer.borderColor = UIColor.white.cgColor
           temp.addTarget(self, action: #selector(pickedButtons(_:)), for: .touchUpInside)
           return temp
       }
       
    
    func setUpViews() {
        clickForOption = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        clickForOption.translatesAutoresizingMaskIntoConstraints = false
        clickForOption.font = UIFont.boldSystemFont(ofSize: 25)
        clickForOption.text = "click your choice for options"
        clickForOption.textAlignment = .center
        let gradient = getGradientLayer(bounds: clickForOption.bounds)
        clickForOption.textColor = gradientColor(bounds: clickForOption.bounds, gradientLayer: gradient)
        view.addSubview(clickForOption)
        
        for food in chosenFoods{
            let temp = optionButton(type: food)
            view.addSubview(temp)
            buttons.append(temp)
        }
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            clickForOption.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            clickForOption.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 4)
        ])
        
        var space = 30
        
        for button in buttons {
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                button.topAnchor.constraint(equalTo: clickForOption.bottomAnchor, constant: CGFloat(space)),
                button.widthAnchor.constraint(equalToConstant: 120)
            ])
            
            space = space + 50
        }
    }
    



}
