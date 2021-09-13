//
//  GroupCompatibilityViewController.swift
//  compatibility
//
//  Created by Kyra Lee on 2/16/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import UIKit

class GroupCompatibilityViewController: UIViewController {
    
    let resources: Resources = Resources()
    var group: Group!
    weak var delegate: deleteGroup!
    
    var groupName: UILabel!
    var overallLabel: UILabel!
    var horoLabel: UILabel!
    var myersLabel: UILabel!
    var enneaLabel: UILabel!
    
    var overallComp: UILabel!
    var horoComp: UILabel!
    var myersComp: UILabel!
    var enneaComp: UILabel!
    
    var deleteGroup: UIButton!
    
    var participantsCV: UICollectionView!
    var participantFlowLayout: UICollectionViewFlowLayout!
    let participantID: String = "participantID"
    
    var symbolCV: UICollectionView!
    var symbolFlowLayout: UICollectionViewFlowLayout!
    let symbolID: String = "symbolID"
    
    init(group: Group, delegate: deleteGroup){
        super.init(nibName: nil, bundle: nil)
        
        self.group = group
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup nav bar
        view.backgroundColor = .white
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = resources.red
        titleLabel.font = resources.headerFont.withSize(25)
        titleLabel.textAlignment = .center
        titleLabel.text = "GROUP COMPATIBILITY"
        
        self.navigationItem.titleView = titleLabel
        
        setUpViews()
        setUpConstraints()
    }
    
    func setUpViews() {
        // do other setup
        
        groupName = UILabel()
        groupName.translatesAutoresizingMaskIntoConstraints = false
        groupName.text = group.groupName
        groupName.textAlignment = .center
        groupName.font = resources.headerFont.withSize(30)
        groupName.textColor = resources.lightRed
        view.addSubview(groupName)
        
        overallLabel = makeLabel(type: "overall", color: resources.determineColor(percent: group.overallComp, which: "comp"))
        horoLabel = makeLabel(type: "horoscope", color: resources.determineColor(percent: group.horoComp, which: "comp"))
        myersLabel = makeLabel(type: "myers-briggs", color: resources.determineColor(percent: group.myersComp, which: "comp"))
        enneaLabel = makeLabel(type: "enneagram", color: resources.determineColor(percent: group.enneaComp, which: "comp"))
        
        overallComp = UILabel()
        overallComp.translatesAutoresizingMaskIntoConstraints = false
        overallComp.text = "\(group.overallComp ?? 0)%"
        overallComp.textAlignment = .center
        overallComp.font = resources.numbersFont.withSize(40)
        overallComp.textColor = resources.determineColor(percent: group.overallComp, which: "comp")
        view.addSubview(overallComp)
        
        horoComp = UILabel()
        horoComp.translatesAutoresizingMaskIntoConstraints = false
        horoComp.text = "\(group.horoComp ?? 0)%"
        horoComp.textAlignment = .center
        horoComp.font = resources.numbersFont.withSize(40)
        horoComp.textColor = resources.determineColor(percent: group.overallComp, which: "comp")
        view.addSubview(horoComp)
        
        myersComp = UILabel()
        myersComp.translatesAutoresizingMaskIntoConstraints = false
        myersComp.text = "\(group.myersComp ?? 0)%"
        myersComp.textAlignment = .center
        myersComp.font = resources.numbersFont.withSize(40)
        myersComp.textColor = resources.determineColor(percent: group.myersComp, which: "comp")
        view.addSubview(myersComp)
        
        enneaComp = UILabel()
        enneaComp.translatesAutoresizingMaskIntoConstraints = false
        enneaComp.text = "\(group.enneaComp ?? 0)%"
        enneaComp.textAlignment = .center
        enneaComp.font = resources.numbersFont.withSize(40)
        enneaComp.textColor = resources.determineColor(percent: group.enneaComp, which: "comp")
        view.addSubview(enneaComp)
        
        participantFlowLayout = UICollectionViewFlowLayout()
        participantFlowLayout.scrollDirection = .horizontal
        participantFlowLayout.minimumInteritemSpacing = 5
        participantFlowLayout.minimumLineSpacing = 5
        
        participantsCV = UICollectionView(frame: .zero, collectionViewLayout: participantFlowLayout)
        participantsCV.translatesAutoresizingMaskIntoConstraints = false
        participantsCV.register(ParticipantCollectionViewCell.self, forCellWithReuseIdentifier: participantID)
        participantsCV.backgroundColor = .white
        participantsCV.dataSource = self
        participantsCV.delegate = self
        participantsCV.contentInsetAdjustmentBehavior = .never
        view.addSubview(participantsCV)
        
        deleteGroup = UIButton()
        deleteGroup.translatesAutoresizingMaskIntoConstraints = false
        deleteGroup.addTarget(self, action: #selector(deleteTheGroup), for: .touchUpInside)
        deleteGroup.setTitle("DELETE COMPANION", for: .normal)
        deleteGroup.setTitleColor(resources.red, for: .normal)
        deleteGroup.titleLabel?.font = resources.headerFont
        deleteGroup.titleLabel?.textAlignment = .center
        deleteGroup.layer.borderWidth = 5
        deleteGroup.layer.borderColor = resources.red.cgColor
        deleteGroup.backgroundColor = resources.lightRed
        view.addSubview(deleteGroup)
    
    }
    
    func setUpConstraints() {
        
    }
    
    func makeLabel(type: String, color: UIColor) -> UILabel {
        let temp = UILabel()
        temp.translatesAutoresizingMaskIntoConstraints = false
        let tempString:NSString = "\(type) compatibility" as NSString
        let mutableString = NSMutableAttributedString(string: tempString as String, attributes: [NSAttributedString.Key.font:resources.headerFont.withSize(26)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSRange(location:0,length:type.count))
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: resources.grey, range: NSRange(location:type.count+1, length:13))
        temp.attributedText = mutableString
        temp.layer.borderWidth = 3
        temp.layer.borderColor = resources.grey.cgColor
        temp.backgroundColor = resources.lightGrey
        temp.textAlignment = .center
        return temp
    }
    
    @objc func deleteTheGroup() {
        delegate.deleteTheGroup(group: self.group)
    }
}

extension GroupCompatibilityViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.participantsCV{
            return 1
        } else {
            return 20 // fix later
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.participantsCV{
            let cell = participantsCV.dequeueReusableCell(withReuseIdentifier: participantID, for: indexPath) as! ParticipantCollectionViewCell
//            cell.configure(name: you.name, horoscope: you.horoscope, myersbriggs: you.myersbriggs, enneagram: you.enneagram, image: pfp ?? UIImage(named: "noPFP")!)
            cell.layer.borderWidth = 5
            cell.layer.borderColor = resources.blue.cgColor //resources.darkBlue.cgColor
            return cell
        } else {
            return UICollectionViewCell()
        }
    }

}

extension GroupCompatibilityViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // if youCV: push edit profile
        if collectionView == self.participantsCV{
            // do nothing
        } else {
            // do nothing
        }
    }
}

extension GroupCompatibilityViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.participantsCV {
            return CGSize(width: view.frame.size.width - 10, height: 80)
        } else {
            // do stuff
            return CGSize(width: 60, height: 20)
        }
    }

}
