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
    var idk : UIButton!
    
    var firstChosen : Bool!
    var findPlaces : UIButton!
    
    var chosenFoods : [String] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        firstChosen = true
        setUpViews()
        setUpConstraints()
        // Do any additional setup after loading the view.
    }
    
    @objc func pushPlaces(_ sender: UIButton) {
        findPlaces.backgroundColor = .blue
        navigationController?.pushViewController(pickPlacesViewController(chosenFoods: chosenFoods), animated: true)
    }
    
    @objc func pickedButtons (_ sender: UIButton) {
        if(firstChosen) {
            firstChosen = false
            findPlaces = UIButton(frame: view.bounds)
            findPlaces.translatesAutoresizingMaskIntoConstraints = false
            findPlaces.setTitle("find restaurants", for: .normal)
            findPlaces.setTitleColor(.black, for: .normal)
            findPlaces.titleLabel!.font = UIFont.boldSystemFont(ofSize: 18)
            findPlaces.layer.cornerRadius = 8
            findPlaces.backgroundColor = .white
            findPlaces.layer.shadowColor = UIColor.white.cgColor
            findPlaces.layer.shadowOpacity = 0.7
            findPlaces.layer.borderWidth = 2
            findPlaces.layer.borderColor = UIColor.white.cgColor
            findPlaces.addTarget(self, action: #selector(pushPlaces(_:)), for: .touchUpInside)
            view.addSubview(findPlaces)
            
            NSLayoutConstraint.activate([
                findPlaces.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                findPlaces.topAnchor.constraint(equalTo: idk.bottomAnchor, constant: 30),
                findPlaces.widthAnchor.constraint(equalToConstant: 160)
            ])
        }
        let gradient = getGradientLayer(bounds: sender.bounds)
        sender.backgroundColor = gradientColor(bounds: sender.bounds, gradientLayer: gradient)
        sender.setTitleColor(.white, for: .normal)
        chosenFoods.append(sender.titleLabel!.text!)
    }
    
    @objc func notWant(_ sender: UIButton) {
        navigationController?.pushViewController(NotWantViewController(), animated: true)
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
        soundsGood = UILabel(frame: CGRect(x: 0, y: 0, width: 600, height: 120))
        soundsGood.translatesAutoresizingMaskIntoConstraints = false
        soundsGood.font = UIFont.boldSystemFont(ofSize: 30)
        soundsGood.text = "what sounds good?"
        soundsGood.textAlignment = .center
        let gradient = getGradientLayer(bounds: soundsGood.bounds)
        soundsGood.textColor = gradientColor(bounds: soundsGood.bounds, gradientLayer: gradient)
        view.addSubview(soundsGood)
        
        chinese = optionButton(type: "chinese")
        view.addSubview(chinese)
        
        korean = optionButton(type: "korean")
        view.addSubview(korean)
        
        greek = optionButton(type: "greek")
        view.addSubview(greek)
        
        american = optionButton(type: "american")
        view.addSubview(american)
        
        mexican = optionButton(type: "mexican")
        view.addSubview(mexican)
        
        japanese = optionButton(type: "japanese")
        view.addSubview(japanese)
        
        italian = optionButton(type: "italian")
        view.addSubview(italian)
        
        misc = optionButton(type: "misc")
        view.addSubview(misc)
        
        idk = optionButton(type: "i don't know...")
        idk.addTarget(self, action: #selector(notWant(_:)), for: .touchUpInside)
        view.addSubview(idk)
        
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            soundsGood.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            soundsGood.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.size.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            chinese.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.frame.size.width / 3),
            chinese.topAnchor.constraint(equalTo: soundsGood.bottomAnchor, constant: 30),
            chinese.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            korean.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                            constant: (view.frame.size.width / 3) * -1),
            korean.topAnchor.constraint(equalTo: soundsGood.bottomAnchor, constant: 30),
            korean.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            greek.centerXAnchor.constraint(equalTo: chinese.centerXAnchor),
            greek.topAnchor.constraint(equalTo: chinese.bottomAnchor, constant: 20),
            greek.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            american.centerXAnchor.constraint(equalTo: korean.centerXAnchor),
            american.topAnchor.constraint(equalTo: korean.bottomAnchor, constant: 20),
            american.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            mexican.centerXAnchor.constraint(equalTo: chinese.centerXAnchor),
            mexican.topAnchor.constraint(equalTo: greek.bottomAnchor, constant: 20),
            mexican.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            japanese.centerXAnchor.constraint(equalTo: korean.centerXAnchor),
            japanese.topAnchor.constraint(equalTo: american.bottomAnchor, constant: 20),
            japanese.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            italian.centerXAnchor.constraint(equalTo: chinese.centerXAnchor),
            italian.topAnchor.constraint(equalTo: mexican.bottomAnchor, constant: 20),
            italian.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            misc.centerXAnchor.constraint(equalTo: korean.centerXAnchor),
            misc.topAnchor.constraint(equalTo: japanese.bottomAnchor, constant: 20),
            misc.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            idk.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            idk.topAnchor.constraint(equalTo: misc.bottomAnchor, constant: 20),
            idk.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    

}
