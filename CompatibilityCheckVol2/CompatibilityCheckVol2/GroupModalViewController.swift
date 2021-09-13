//
//  GroupModalViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 2/3/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class GroupModalViewController: UIViewController {
    
    let resources: Resources = Resources()
    weak var delegate: newGroup!
    var doneButton: UIButton!
    var exitButton: UIButton!
    var createGroup: UILabel!
    var companions: [Companion]!
    var companionTV: UITableView!
    var companionID: String = "companionID"
    var selectCompanions: UILabel!
    var groupName: UITextField!
    var enterButton: UIButton!
 //   var TVcells: [CompanionTableViewCell] = []
    var companionsInGroup: [Companion]

    init(companions: [Companion], delegate: newGroup){
        self.companionsInGroup = []
        super.init(nibName: nil, bundle: nil)
        
        self.companions = companions
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        print("setting up views")
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
        doneButton.addTarget(self, action: #selector(readyToDone), for: .touchUpInside)
        view.addSubview(doneButton)
        
        exitButton = UIButton()
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.setTitle("EXIT", for: .normal)
        exitButton.setTitleColor(.blue, for: .normal)
        exitButton.titleLabel?.font = resources.headerFont.withSize(30)
        exitButton.titleLabel?.textAlignment = .right
        exitButton.addTarget(self, action: #selector(readyToExit), for: .touchUpInside)
        view.addSubview(exitButton)
        
        createGroup = UILabel()
        createGroup.translatesAutoresizingMaskIntoConstraints = false
        createGroup.text = "CREATE GROUP"
        createGroup.font = resources.headerFont
        createGroup.textAlignment = .center
        createGroup.textColor = resources.red
        view.addSubview(createGroup)
        
        companionTV = UITableView()
        companionTV.translatesAutoresizingMaskIntoConstraints = false
        companionTV.register(CompanionTableViewCell.self, forCellReuseIdentifier: companionID)
        companionTV.delegate = self
        companionTV.dataSource = self
        view.addSubview(companionTV)
        
        groupName = UITextField()
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupName.text = "group name"
        groupName.textAlignment = .center
        groupName.layer.cornerRadius = 15.0
        groupName.layer.borderColor = UIColor.gray.cgColor
        groupName.isUserInteractionEnabled = true
        groupName.textColor = .gray
        groupName.font = resources.responseFont.withSize(45)
        groupName.backgroundColor  = UIColor(red: 0.85, green: 0.85, blue: 0.84, alpha: 1.00)
        groupName.isUserInteractionEnabled = true
        groupName.addTarget(self, action: #selector(clearField), for: UIControl.Event.editingDidBegin)
        view.addSubview(groupName)
        
        enterButton = UIButton()
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        enterButton.setTitle("ENTER", for: .normal)
        enterButton.setTitleColor(.blue, for: .normal)
        enterButton.titleLabel?.font = resources.headerFont.withSize(20)
        enterButton.titleLabel?.textAlignment = .center
        enterButton.addTarget(self, action: #selector(enterGroupName), for: .touchUpInside)
        view.addSubview(enterButton)
        
        selectCompanions = UILabel()
        selectCompanions.translatesAutoresizingMaskIntoConstraints = false
        selectCompanions.text = "select companions to add to group"
        selectCompanions.textColor = .black
        selectCompanions.font = resources.numbersFont.withSize(20)
        selectCompanions.textAlignment = .center
        view.addSubview(selectCompanions)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -7)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7)
        ])
        
        NSLayoutConstraint.activate([
            createGroup.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            createGroup.topAnchor.constraint(equalTo: doneButton.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            groupName.heightAnchor.constraint(equalToConstant: 40),
            groupName.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            groupName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            groupName.topAnchor.constraint(equalTo: createGroup.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            enterButton.topAnchor.constraint(equalTo: groupName.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            selectCompanions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            selectCompanions.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            companionTV.widthAnchor.constraint(equalToConstant: view.frame.size.width - 10),
            companionTV.heightAnchor.constraint(equalToConstant: view.frame.size.width - 50), // 350
            companionTV.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            companionTV.topAnchor.constraint(equalTo: selectCompanions.bottomAnchor, constant: 10)
        ])
    }
    
    @objc func enterGroupName() {
        let wholeThing = "select companions to add to \(groupName.text ?? "group")"
        let nameLen = groupName.text?.count ?? 5
        //selectCompanions.text = "select companions to add to \(groupName.text ?? "group")"
        
        let groupString:NSString = wholeThing as NSString
        let mutableString = NSMutableAttributedString(string: groupString as String, attributes: [NSAttributedString.Key.font:resources.numbersFont.withSize(20)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.blue, range: NSRange(location:28,length:nameLen))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location:0, length:27))
        selectCompanions.attributedText = mutableString
    }
    
    @objc func readyToDone() {
        delegate.getGroup(group: companionsInGroup, groupName: groupName.text ?? "group")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func readyToExit() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func clearField() {
        groupName.text = ""
    }

}

extension GroupModalViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //companionTV.deselectRow(at: indexPath, animated: true)
        
        let cell:CompanionTableViewCell = companionTV.cellForRow(at: indexPath) as! CompanionTableViewCell
        cell.contentView.backgroundColor = resources.lightRed

        companionsInGroup.append(companions[indexPath.row])
    }

}

extension GroupModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < companions.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: companionID, for: indexPath) as! CompanionTableViewCell
            let companion = companions[indexPath.row]
            cell.configure(for: companion)
            cell.layer.borderWidth = 5
            cell.layer.borderColor = resources.seagreen.cgColor
            cell.backgroundColor = resources.lightSeagreen
            cell.selectedBackgroundView?.backgroundColor = resources.lightRed
            //cell.selectionStyle = CompanionTableViewCell.SelectionStyle.gray
            // TVcells.append(cell)
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
