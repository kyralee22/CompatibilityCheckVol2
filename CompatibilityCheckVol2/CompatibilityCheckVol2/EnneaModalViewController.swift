//
//  EnneaModalViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/29/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class EnneaModalViewController: UIViewController {
    
    var ennea: EnneagramDescriptions!
    let resources: Resources = Resources()
    
    var doneButton: UIButton!
    var pic: UIImageView!
    var nickname: UILabel!
    
    var fearLabel: UILabel!
    var desireLabel: UILabel!
    var motiveLabel: UILabel!
    var overallLabel: UILabel!
    
    var fear: UITextView!
    var desire: UITextView!
    var motive: UITextView!
    var overall: UITextView!
    
    init(ennea: EnneagramDescriptions){
        super.init(nibName: nil, bundle: nil)
        
        self.ennea = ennea
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        doneButton = UIButton()
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("DONE", for: .normal)
        doneButton.setTitleColor(.blue, for: .normal)
        doneButton.titleLabel?.font = resources.headerFont.withSize(30)
        doneButton.titleLabel?.textAlignment = .right
        doneButton.addTarget(self, action: #selector(readyToExit), for: .touchUpInside)
        view.addSubview(doneButton)
        
        pic = UIImageView(image: UIImage(named: ennea.enneagram))
        pic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pic)
        
        nickname = UILabel()
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.text = "\(ennea.nickname ?? "")".quoted
        nickname.font = resources.headerFont.withSize(CGFloat(28))
        nickname.textColor = .gray
        nickname.textAlignment = .center
        view.addSubview(nickname)
        
        fearLabel = UILabel()
        fearLabel.translatesAutoresizingMaskIntoConstraints = false
        let fearString:NSString = "BASIC FEAR"
        var mutableString = NSMutableAttributedString(string: fearString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:5))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.red, range: NSRange(location:6, length:4))
        fearLabel.attributedText = mutableString
        fearLabel.textAlignment = .center
        view.addSubview(fearLabel)
        
        desireLabel = UILabel()
        desireLabel.translatesAutoresizingMaskIntoConstraints = false
        let desireString:NSString = "BASIC DESIRE"
        mutableString = NSMutableAttributedString(string: desireString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:5))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.red, range: NSRange(location:6, length:6))
        desireLabel.attributedText = mutableString
        desireLabel.textAlignment = .center
        view.addSubview(desireLabel)
        
        motiveLabel = UILabel()
        motiveLabel.translatesAutoresizingMaskIntoConstraints = false
        let motiveString:NSString = "KEY MOTIVATION"
        mutableString = NSMutableAttributedString(string: motiveString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0,length:3))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.red, range: NSRange(location:4, length:10))
        motiveLabel.attributedText = mutableString
        motiveLabel.textAlignment = .center
        view.addSubview(motiveLabel)
        
        overallLabel = UILabel()
        overallLabel.translatesAutoresizingMaskIntoConstraints = false
        overallLabel.text = "OVERALL"
        overallLabel.font = resources.headerFont.withSize(26)
        overallLabel.textAlignment = .center
        overallLabel.textColor = resources.blue
        view.addSubview(overallLabel)
        
        fear = UITextView()
        fear.translatesAutoresizingMaskIntoConstraints = false
        fear.isScrollEnabled = false
//        print("before deleting quotes: \(ennea.fear)")
//        print("after deleting quotes: \((ennea.fear).replacingOccurrences(of: "\"", with: ""))")
        fear.text = (ennea.fear).replacingOccurrences(of: "\"", with: "")
       // print("fear text: \(fear.text)")
        fear.font = resources.numbersFont.withSize(20)
        fear.textColor = .black
        fear.textAlignment = .center
        view.addSubview(fear)
        
        desire = UITextView()
        desire.translatesAutoresizingMaskIntoConstraints = false
        desire.isScrollEnabled = false
        desire.text = (ennea.desire).replacingOccurrences(of: "\"", with: "")
        desire.font = resources.numbersFont.withSize(20)
        desire.textColor = .black
        desire.textAlignment = .center
        view.addSubview(desire)
        
        motive = UITextView()
        motive.translatesAutoresizingMaskIntoConstraints = false
        motive.isScrollEnabled = false
        motive.text = (ennea.motive).replacingOccurrences(of: "\"", with: "")
        motive.font = resources.numbersFont.withSize(20)
        motive.textColor = .black
        motive.textAlignment = .center
        view.addSubview(motive)
        
        overall = UITextView()
        overall.translatesAutoresizingMaskIntoConstraints = false
        overall.isScrollEnabled = false
        overall.text = (ennea.overall).replacingOccurrences(of: "\"", with: "")
        overall.font = resources.numbersFont.withSize(20)
        overall.textColor = .black
        overall.textAlignment = .center
        view.addSubview(overall)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            pic.widthAnchor.constraint(equalToConstant: 80),
            pic.heightAnchor.constraint(equalToConstant: 80),
            pic.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            pic.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25)
        ])
        
        NSLayoutConstraint.activate([
            nickname.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nickname.topAnchor.constraint(equalTo: pic.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            fearLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            fearLabel.topAnchor.constraint(equalTo: nickname.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            fear.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            fear.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            fear.topAnchor.constraint(equalTo: fearLabel.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            desireLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            desireLabel.topAnchor.constraint(equalTo: fear.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            desire.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            desire.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            desire.topAnchor.constraint(equalTo: desireLabel.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            motiveLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            motiveLabel.topAnchor.constraint(equalTo: desire.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            motive.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            motive.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            motive.topAnchor.constraint(equalTo: motiveLabel.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            overallLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            overallLabel.topAnchor.constraint(equalTo: motive.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            overall.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            overall.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            overall.topAnchor.constraint(equalTo: overallLabel.bottomAnchor, constant: 5)
        ])
    }
    
    @objc func readyToExit() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}
