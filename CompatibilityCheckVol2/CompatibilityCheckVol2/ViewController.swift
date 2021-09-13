//
//  ViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 1/25/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit
import QuartzCore
//import SwiftCSV

protocol newPerson: class{
    func getCompanion(companion: Companion)
    func getYou(you: You)
    func getPic(image: UIImage)
}

protocol deletePerson: class {
    func deleteCompanion(companion: Companion)
}

protocol newGroup: class {
    func getGroup(group: [Companion], groupName: String)
}

protocol deleteGroup: class {
    func deleteTheGroup(group: Group)
}


// to do
// group compatibility VC

class ViewController: UIViewController {

    var yourCompanions: UILabel!
    var companionTV: UITableView!
    var sortBy: UILabel!
    var sortOverall: UIButton!
    var sortHoro: UIButton!
    var sortMyers: UIButton!
    var sortEnnea: UIButton!
    var youLayout: UICollectionViewFlowLayout!
    var youCV: UICollectionView!
    var newCompanion: UIButton!

    let resources: Resources = Resources()
    let csv: csvRead = csvRead()
    var sort: [String:Bool] = ["overall":false, "horoscope":false, "myers-briggs":false, "enneagram":false]
    var sortFilters: [UIButton]!
    
    let youID: String = "youIdentifier"
    let companionID: String = "companionIdentifier"
    var companions: [Companion] = []
    var filters: [String] = ["overall", "horoscope", "myers-briggs", "enneagram"]
    var you: You = You(pic: UIImage(named: "noPFP")!, name: "name", horoscope: "zodiac sign", myersbriggs: "personality type", enneagram: "0")
    var pfp: UIImage!
    
    var createGroup: UIButton!
    var groups: [Group] = []
    var groupFlowLayout: UICollectionViewFlowLayout!
    var groupCV: UICollectionView!
    var groupID: String = "groupIdentifier"
    var cvWidth: Float = 0.0
        
    override func viewDidLoad() {

        super.viewDidLoad()
        
        view.backgroundColor = .white

        // setup nav bar
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "COMPATIBILITYCHECK"
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        let boldString = NSMutableAttributedString(string: titleLabel.text!, attributes: attributes)
        titleLabel.attributedText = boldString
        titleLabel.textColor = resources.blue
        titleLabel.font = resources.headerFont.withSize(30)
        titleLabel.textAlignment = .center

        self.navigationItem.titleView = titleLabel

        setUpViews()
        setUpConstraints()

        sortFilters = [sortOverall, sortHoro, sortMyers, sortEnnea]
        buttonPress()
    }
    
    func buttonPress() {
        for button in sortFilters {
            for key in sort.keys {
                if sort[button.titleLabel?.text ?? ""] == true {
                    button.backgroundColor = resources.purple
                    button.setTitleColor(resources.lightPurple, for: .normal)
                } else {
                    button.backgroundColor = resources.lightPurple
                    button.setTitleColor(resources.purple, for: .normal)
                }
            }
        }
    }
    
    @objc func sortButton(_ sender: UIButton) {
        var sorted: String!
        
        if sender == sortOverall {
            sorted = "overall"
            companions = companions.sorted(by: { $0.overallComp > $1.overallComp})
        } else if sender == sortHoro {
            sorted = "horoscope"
            companions = companions.sorted(by: { $0.horoComp > $1.horoComp})
        } else if sender == sortMyers {
            sorted = "myers-briggs"
            companions = companions.sorted(by: { $0.myersComp > $1.myersComp})
        } else if sender == sortEnnea {
            sorted = "enneagram"
            companions = companions.sorted(by: { $0.enneaComp > $1.enneaComp})
        }
        
        allElseFalse(dict: &sort, filter: sorted)
        
        companionTV.reloadData()
        viewDidLoad()

    }
    
    func allElseFalse(dict: inout [String:Bool], filter: String) {
        for key in dict.keys {
            if key == filter {
                dict[key] = true
            } else {
                dict[key] = false
            }
        }
    }
    
    func setUpViews() {
        
        sortBy = UILabel()
        sortBy.translatesAutoresizingMaskIntoConstraints = false
        sortBy.text = "SORT COMPANIONS"
        sortBy.font = resources.headerFont.withSize(20)
        sortBy.textAlignment = .center
        sortBy.textColor = resources.purple
        sortBy.backgroundColor = resources.lightPurple
        sortBy.layer.borderWidth = 3
        sortBy.layer.borderColor = resources.purple.cgColor
        view.addSubview(sortBy)
        
        sortOverall = UIButton()
        sortOverall.translatesAutoresizingMaskIntoConstraints = false
        sortOverall.setTitle("overall", for: .normal)
        sortOverall.setTitleColor(resources.purple, for: .normal)
        sortOverall.backgroundColor = resources.lightPurple
        sortOverall.layer.cornerRadius = 20
        sortOverall.titleLabel?.font = resources.numbersFont.withSize(25)
        sortOverall.titleLabel?.textAlignment = .center
      //  sortOverall.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
        sortOverall.addTarget(self, action: #selector(sortButton(_:)), for: .touchUpInside)
        view.addSubview(sortOverall)
        
        sortHoro = UIButton()
        sortHoro.translatesAutoresizingMaskIntoConstraints = false
        sortHoro.setTitle("horoscope", for: .normal)
        sortHoro.setTitleColor(resources.purple, for: .normal)
        sortHoro.backgroundColor = resources.lightPurple
        sortHoro.layer.cornerRadius = 20
        sortHoro.titleLabel?.font = resources.numbersFont.withSize(25)
        sortHoro.titleLabel?.textAlignment = .center
        sortHoro.addTarget(self, action: #selector(sortButton(_:)), for: .touchUpInside)
      //  sortHoro.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
        view.addSubview(sortHoro)
        
        sortMyers = UIButton()
        sortMyers.translatesAutoresizingMaskIntoConstraints = false
        sortMyers.setTitle("myers-briggs", for: .normal)
        sortMyers.setTitleColor(resources.purple, for: .normal)
        sortMyers.backgroundColor = resources.lightPurple
        sortMyers.layer.cornerRadius = 20
        sortMyers.titleLabel?.font = resources.numbersFont.withSize(25)
        sortMyers.titleLabel?.textAlignment = .center
        sortMyers.addTarget(self, action: #selector(sortButton(_:)), for: .touchUpInside)
     //   sortMyers.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
        view.addSubview(sortMyers)
        
        sortEnnea = UIButton()
        sortEnnea.translatesAutoresizingMaskIntoConstraints = false
        sortEnnea.setTitle("enneagram", for: .normal)
        sortEnnea.setTitleColor(resources.purple, for: .normal)
        sortEnnea.backgroundColor = resources.lightPurple
        sortEnnea.layer.cornerRadius = 20
        sortEnnea.titleLabel?.font = resources.numbersFont.withSize(25)
        sortEnnea.titleLabel?.textAlignment = .center
        sortEnnea.addTarget(self, action: #selector(sortButton(_:)), for: .touchUpInside)
       // sortEnnea.addTarget(self, action: #selector(buttonPress(_:)), for: .touchUpInside)
        view.addSubview(sortEnnea)
        
        yourCompanions = UILabel()
        yourCompanions.translatesAutoresizingMaskIntoConstraints = false
        yourCompanions.text = "your companions"
        yourCompanions.font = UIFontMetrics.default.scaledFont(for: resources.headerFont)
        yourCompanions.adjustsFontForContentSizeCategory = true
        yourCompanions.textColor = resources.seagreen
        view.addSubview(yourCompanions)
        
        youLayout = UICollectionViewFlowLayout()
        youLayout.scrollDirection = .horizontal
        youLayout.minimumLineSpacing = 0
        youLayout.minimumInteritemSpacing = 0
        
        youCV = UICollectionView(frame: .zero, collectionViewLayout: youLayout)
        youCV.translatesAutoresizingMaskIntoConstraints = false
        youCV.register(youCollectionViewCell.self, forCellWithReuseIdentifier: youID)
        youCV.backgroundColor = .white
        youCV.delegate = self
        youCV.dataSource = self
        view.addSubview(youCV)
        
        newCompanion = UIButton()
        newCompanion.translatesAutoresizingMaskIntoConstraints = false
        newCompanion.addTarget(self, action: #selector(addCompanion), for: .touchUpInside)
        newCompanion.setTitle("NEW COMPANION", for: .normal)
        newCompanion.setTitleColor(resources.yellow, for: .normal)
        newCompanion.titleLabel?.font = resources.headerFont
        newCompanion.titleLabel?.textAlignment = .center
        newCompanion.layer.borderWidth = 5
        newCompanion.layer.borderColor = resources.yellow.cgColor
        newCompanion.backgroundColor = resources.lightYellow
        view.addSubview(newCompanion)
        
        companionTV = UITableView()
        companionTV.translatesAutoresizingMaskIntoConstraints = false
        companionTV.register(CompanionTableViewCell.self, forCellReuseIdentifier: companionID)
        companionTV.delegate = self
        companionTV.dataSource = self
        view.addSubview(companionTV)
        
        createGroup = UIButton()
        createGroup.translatesAutoresizingMaskIntoConstraints = false
        createGroup.addTarget(self, action: #selector(addGroup), for: .touchUpInside)
        createGroup.setTitle("CREATE GROUP", for: .normal)
        createGroup.setTitleColor(resources.red, for: .normal)
        createGroup.titleLabel?.font = resources.headerFont.withSize(30)
        createGroup.titleLabel?.textAlignment = .center
        createGroup.layer.borderWidth = 3
        createGroup.layer.borderColor = resources.red.cgColor
        createGroup.backgroundColor = resources.lightRed
        view.addSubview(createGroup)
        
        groupFlowLayout = UICollectionViewFlowLayout()
        groupFlowLayout.scrollDirection = .horizontal
        groupFlowLayout.minimumInteritemSpacing = 5
        groupFlowLayout.minimumLineSpacing = 5
        
        groupCV = UICollectionView(frame: .zero, collectionViewLayout: groupFlowLayout)
        groupCV.translatesAutoresizingMaskIntoConstraints = false
        groupCV.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: groupID)
        groupCV.backgroundColor = .white
        groupCV.dataSource = self
        groupCV.delegate = self
        groupCV.contentInsetAdjustmentBehavior = .never
        view.addSubview(groupCV)
        
    }
    
    func setUpConstraints(){
        let screenWidth = view.frame.size.width
        let buttonWidth = (screenWidth / 2) - 20
        let buttonHeight = sortOverall.intrinsicContentSize.height

        NSLayoutConstraint.activate([
            youCV.widthAnchor.constraint(equalToConstant: screenWidth - 10),
            youCV.heightAnchor.constraint(equalToConstant: 80),
            youCV.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            youCV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            yourCompanions.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            yourCompanions.topAnchor.constraint(equalTo: youCV.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            newCompanion.widthAnchor.constraint(equalToConstant: screenWidth - 10),
            newCompanion.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            newCompanion.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            companionTV.widthAnchor.constraint(equalToConstant: screenWidth - 10),
            companionTV.heightAnchor.constraint(equalToConstant: 280), // 350
            companionTV.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            companionTV.topAnchor.constraint(equalTo: yourCompanions.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            sortBy.widthAnchor.constraint(equalToConstant: buttonWidth),
            sortBy.heightAnchor.constraint(equalToConstant: buttonHeight),
            sortBy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            sortBy.topAnchor.constraint(equalTo: companionTV.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            sortOverall.widthAnchor.constraint(equalToConstant: buttonWidth),
            sortOverall.leadingAnchor.constraint(equalTo: sortBy.trailingAnchor, constant: 10),
            sortOverall.centerYAnchor.constraint(equalTo: sortBy.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sortHoro.widthAnchor.constraint(equalToConstant: buttonWidth),
            sortHoro.centerXAnchor.constraint(equalTo: sortOverall.centerXAnchor),
            sortHoro.topAnchor.constraint(equalTo: sortOverall.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            sortMyers.widthAnchor.constraint(equalToConstant: buttonWidth),
            sortMyers.centerXAnchor.constraint(equalTo: sortOverall.centerXAnchor),
            sortMyers.topAnchor.constraint(equalTo: sortHoro.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            sortEnnea.widthAnchor.constraint(equalToConstant: buttonWidth),
            sortEnnea.centerXAnchor.constraint(equalTo: sortOverall.centerXAnchor),
            sortEnnea.topAnchor.constraint(equalTo: sortMyers.bottomAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            createGroup.widthAnchor.constraint(equalToConstant: createGroup.intrinsicContentSize.width + 10),
            createGroup.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            createGroup.topAnchor.constraint(equalTo: sortEnnea.bottomAnchor, constant: 23)
        ])
        
        NSLayoutConstraint.activate([
            groupCV.widthAnchor.constraint(equalToConstant: view.frame.size.width - createGroup.intrinsicContentSize.width - 16),
            groupCV.heightAnchor.constraint(equalToConstant: createGroup.intrinsicContentSize.height),
            groupCV.leadingAnchor.constraint(equalTo: createGroup.trailingAnchor, constant: 6),
            groupCV.centerYAnchor.constraint(equalTo: createGroup.centerYAnchor)
        ])
    }
    
    @objc func addGroup() {
        if companions.count == 0 {
            let alert = UIAlertController(title: "Who's in the Group?", message: "Please add your companions before making a group!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default"), style: .default))
            self.present(alert, animated: true, completion: nil)
        } else {
            let groupMVC = GroupModalViewController(companions: companions, delegate: self)
            present(groupMVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func addCompanion(){
        if you.isDefault() {
            let alert = UIAlertController(title: "Nothing to compare...", message: "Please create your profile before adding companion!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "default"), style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        // push profile view
        navigationController?.pushViewController(ProfileViewController(isYou: false, delegate: self, nameText: "their full name", horoText: "their horoscope", myersText: "their personality type", pfp: UIImage(named: "noPFP")!), animated: true)
    }
    
    func getCompanionTV() -> UITableView {
        return companionTV
    }
    
}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        companionTV.deselectRow(at: indexPath, animated: true)
        
        navigationController?.pushViewController(CompatibilityViewController(you: you, companion: companions[indexPath.row], delegate: self), animated: true)
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < companions.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: companionID, for: indexPath) as! CompanionTableViewCell
            let companion = companions[indexPath.row]
            companion.configure(you: you)
            cell.configure(for: companion)
            cell.layer.borderWidth = 5
            cell.layer.borderColor = resources.seagreen.cgColor
            cell.backgroundColor = resources.lightSeagreen
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.youCV{
            return 1
        } else {
            return groups.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.youCV{
            let cell = youCV.dequeueReusableCell(withReuseIdentifier: youID, for: indexPath) as! youCollectionViewCell
            cell.configure(name: you.name, horoscope: you.horoscope, myersbriggs: you.myersbriggs, enneagram: you.enneagram, image: pfp ?? UIImage(named: "noPFP")!)
            cell.layer.borderWidth = 5
            cell.layer.borderColor = resources.blue.cgColor //resources.darkBlue.cgColor
            return cell
        } else {
            let cell = groupCV.dequeueReusableCell(withReuseIdentifier: groupID, for: indexPath) as! GroupCollectionViewCell
//            print("index path section for \(groups[indexPath.section].groupName): \(indexPath.section)")
            cell.configure(group: groups[indexPath.item])
            cell.layer.borderWidth = 3
            cell.layer.borderColor = resources.red.cgColor //resources.darkBlue.cgColor
            return cell
        }
    }

}

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // if youCV: push edit profile
        if collectionView == self.youCV{
            navigationController?.pushViewController(ProfileViewController(isYou: true, delegate: self, nameText: you.name, horoText: you.horoscope, myersText: you.myersbriggs, pfp: pfp ?? UIImage(named: "noPFP")!), animated: true)
        } else {
            navigationController?.pushViewController(GroupCompatibilityViewController(group: groups[indexPath.section], delegate: self), animated: true)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.youCV {
            return CGSize(width: view.frame.size.width - 10, height: 80)
        } else {
            // do stuff
            return CGSize(width: groupCV.bounds.width - 30, height: groupCV.bounds.height)
        }
    }

}

extension UIImageView {

    func makeRounded() {
        self.frame.size.width = 65
        self.frame.size.height = 65
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
}

extension ViewController: newPerson {
    func getCompanion(companion: Companion) {
        companions.append(companion)
        companionTV.reloadData()
        viewDidLoad()
    }
    func getYou(you: You) {
        self.you = you
        viewDidLoad()
    }
    
    func getPic(image: UIImage) {
        self.pfp = image
    }
}

extension ViewController: deletePerson {
    func deleteCompanion(companion: Companion) {
        var index = 0
        for i in 0..<companions.count {
            if companions[i].equals(companion: companion) {
                index = i
            }
        }
        companions.remove(at: index)
        companionTV.reloadData()
        viewDidLoad()
    }
}

extension ViewController: newGroup {
    func getGroup(group: [Companion], groupName: String) {
        let temp = Group(you: you, companions: group, name: groupName)
        if temp.overallComp != 0 {
            groups.append(temp)
            for group in groups {
                print("group: \(group.groupName)")
            }
            viewDidLoad()
        }
    }
}

extension ViewController: deleteGroup {
    func deleteTheGroup(group: Group) {
        var index = 0
        for g in 0..<groups.count {
            if groups[g].groupName == group.groupName {
                index = g
            }
        }
        groups.remove(at: index)
    }
}

