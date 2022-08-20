//
//  ViewController.swift
//  testapp
//
//  Created by Kyra Lee on 9/17/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var nav = UINavigationController()
    var button = UIButton()
    var collection = UICollectionView()
    var cvlayout = UICollectionViewFlowLayout()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(bringmvc), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        cvlayout = UICollectionViewFlowLayout()
        cvlayout.scrollDirection = .vertical
        
        collection = UICollectionView(frame: .zero, collectionViewLayout: cvlayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CVCell")
        collection.delegate = self
        collection.dataSource = self
        view.addSubview(collection)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
    }
    
    
    
    @objc func bringmvc(_ sender: UIButton) {
        print("clicked button")
        navigationController?.pushViewController(ButtonViewController(), animated: true)
    }

}

extension ViewController : UICollectionViewDelegate {
    
}

extension ViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collection.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! CollectionViewCell
        cell.configure(num: indexPath.count)
        return cell
    }
    
    
}
