//
//  DinnerViewController.swift
//  where2eat
//
//  Created by Kyra Lee on 12/31/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class DinnerViewController: UIViewController {
    
    var soundsGood : UILabel!
    // 8 options
    var chinese : UIButton!
    var korean : UIButton!
    var greek : UIButton!
    var american : UIButton!
    var mexican : UIButton!
    var japanese : UIButton!
    var italian : UIButton!
    var misc : UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    func setUpViews() {
        soundsGood = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        soundsGood.translatesAutoresizingMaskIntoConstraints = false
        soundsGood.font = UIFont.boldSystemFont(ofSize: 30)
        soundsGood.text = "what sounds good?"
        soundsGood.textAlignment = .center
        let gradient = getGradientLayer(bounds: soundsGood.bounds)
        soundsGood.textColor = gradientColor(bounds: soundsGood.bounds, gradientLayer: gradient)
        view.addSubview(soundsGood)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            soundsGood.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            soundsGood.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    

}
