//
//  ButtonViewController.swift
//  testapp
//
//  Created by Kyra Lee on 9/17/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        var display = UILabel()
        display.text = "you pressed the button :D"
        view.addSubview(display)
        
        NSLayoutConstraint.activate([
            display.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            display.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
