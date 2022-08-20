//
//  ViewController.swift
//  where2eat
//
//  Created by Kyra Lee on 12/26/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var welcome : UILabel!
    var breakfast : UIButton!
    var dinner : UIButton!
    var viewGradient : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = .black
        setUpViews()
        setUpConstraints()
    }

    @objc func breakfastOptions(_ sender: UIButton) {
        let gradient = getGradientLayer(bounds: sender.bounds)
        sender.backgroundColor = gradientColor(bounds: sender.bounds, gradientLayer: gradient)
        sender.setTitleColor(.white, for: .normal)
    }
    
    @objc func dinnerOptions(_ sender: UIButton) {
        let gradient = getGradientLayer(bounds: sender.bounds)
        sender.backgroundColor = gradientColor(bounds: sender.bounds, gradientLayer: gradient)
        sender.setTitleColor(.white, for: .normal)
        navigationController?.pushViewController(DinnerViewController(), animated: true)
    }
    
    func setUpViews() {
        welcome = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        welcome.font = UIFont.boldSystemFont(ofSize: 30)
        welcome.translatesAutoresizingMaskIntoConstraints = false
        welcome.text = "welcome hangry user"
        welcome.textAlignment = .center
        let gradient = getGradientLayer(bounds: welcome.bounds)
        welcome.textColor = gradientColor(bounds: welcome.bounds, gradientLayer: gradient)
        view.addSubview(welcome)
        
        breakfast = UIButton(frame: view.bounds)
        breakfast.translatesAutoresizingMaskIntoConstraints = false
        breakfast.setTitle("breakfast options", for: .normal)
        breakfast.setTitleColor(.black, for: .normal)
        breakfast.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        breakfast.layer.cornerRadius = 8
        breakfast.backgroundColor = .white
        breakfast.layer.shadowColor = UIColor.white.cgColor
        breakfast.layer.shadowOpacity = 0.7
        breakfast.layer.borderWidth = 2
        breakfast.layer.borderColor = UIColor.white.cgColor
        breakfast.addTarget(self, action: #selector(breakfastOptions(_:)), for: .touchUpInside)
        view.addSubview(breakfast)
        
        dinner = UIButton(frame: view.bounds)
        dinner.translatesAutoresizingMaskIntoConstraints = false
        dinner.setTitle("dinner options", for: .normal)
        dinner.setTitleColor(.black, for: .normal)
        dinner.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
        dinner.layer.cornerRadius = 8
        dinner.backgroundColor = .white
        dinner.layer.shadowColor = UIColor.white.cgColor
        dinner.layer.shadowOpacity = 0.7
        dinner.layer.borderWidth = 2
        dinner.layer.borderColor = UIColor.white.cgColor
        dinner.addTarget(self, action: #selector(dinnerOptions(_:)), for: .touchUpInside)
        view.addSubview(dinner)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            welcome.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            welcome.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 3)
        ])
       NSLayoutConstraint.activate([
            breakfast.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            breakfast.topAnchor.constraint(equalTo: welcome.bottomAnchor, constant: 120),
            breakfast.widthAnchor.constraint(equalToConstant: 200)
        ])
    
        NSLayoutConstraint.activate([
            dinner.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dinner.topAnchor.constraint(equalTo: breakfast.bottomAnchor, constant: 20),
            dinner.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

}

func getGradientLayer(bounds : CGRect) -> CAGradientLayer{
    let gradient = CAGradientLayer()
    gradient.frame = bounds
    //order of gradient colors
    gradient.colors = [UIColor.red.cgColor,UIColor.blue.cgColor, UIColor.green.cgColor]
    // start and end points
    gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    return gradient
}

func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
    UIGraphicsBeginImageContext(gradientLayer.bounds.size)
      //create UIImage by rendering gradient layer.
    gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
      //get gradient UIcolor from gradient UIImage
    return UIColor(patternImage: image!)
}

