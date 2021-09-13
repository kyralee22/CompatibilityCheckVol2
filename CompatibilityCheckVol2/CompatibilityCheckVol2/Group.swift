//
//  Group.swift
//  compatibility
//
//  Created by Kyra Lee on 2/1/21.
//  Copyright © 2021 Kyra Lee. All rights reserved.
//

import Foundation

class Group {
    let csv: csvRead = csvRead()
    var groupName: String!
    var horoscopes: [String] = []
    var MBTI: [String] = []
    var enneagrams: [String] = []
    var horoComp: Int!
    var myersComp: Int!
    var enneaComp: Int!
    var overallComp: Int!
    
    init(you: You, companions: [Companion], name: String) {
        
        self.groupName = name
        for companion in companions {
            horoscopes.append(companion.horoscope)
            MBTI.append(companion.myersbriggs)
            enneagrams.append(companion.enneagram)
        }
        
        horoscopes.append(you.horoscope)
        MBTI.append(you.myersbriggs)
        enneagrams.append(you.enneagram)
        
        horoscopeComp()
        MBTIComp()
        enneagramComp()
                
        var count = 0
        if self.horoComp != 0 {
            count += 1
        }
        if self.myersComp != 0 {
            count += 1
        }
        if self.enneaComp != 0 {
            count += 1
        }
        
        if count > 0 {
            self.overallComp = (self.horoComp + self.myersComp + self.enneaComp) / count
        } else {
            self.overallComp = 0
        }
    }
    
    func comp(people: [String], type: String) -> Int {
        var temp = [Int: [Int]]()
        for person in 0..<people.count {
        for other in 0..<people.count {
            if person != other {
                var comp: Float = 0
                if type == "horoscope" {
                    comp = csv.compareHoroscopes(yours: people[person], theirs: people[other])
                }
                if type == "myersbriggs" {
                    comp = csv.compareMBTI(yours: people[person], theirs: people[other])
                }
                if type == "enneagram" {
                    comp = csv.compareEnneagrams(yours: people[person], theirs: people[other])
                }
                let valArray: [Int] = [Int(comp)]
                temp[person] = (valArray)
            }
        }
    }
            
        for key in temp.keys {
            var total = 0
            for each in temp[key] ?? [] {
                total += each
            }
            temp[key] = [total/((temp[key])?.count ?? 1)]
        }
        
        var avg = 0
        for key in temp.keys {
            avg += temp[key]?[0] ?? 0
        }
        
        return avg / temp.count
    }
    
    func horoscopeComp() {
        horoComp = comp(people: horoscopes, type: "horoscope")
//        var temp = [Int]()
//        for person in 0..<horoscopes.count {
//            for other in 0..<horoscopes.count {
//                if person != other {
//                    let comp = csv.compareHoroscopes(yours: horoscopes[person], theirs: horoscopes[other])
//                    temp.append(Int(comp))
//                }
//            }
//        }
//
//        var overall = 0
//        for each in temp {
//            overall += each
//        }
//
//        horoComp = overall/horoscopes.count
    }
    
    func MBTIComp() {
        myersComp = comp(people: MBTI, type: "myersbriggs")
//        var temp = [Int]()
//        for person in 0..<MBTI.count {
//            for other in 0..<MBTI.count {
//                if person != other {
//                    let comp = csv.compareMBTI(yours: MBTI[person], theirs: MBTI[other])
//                    temp.append(Int(comp))
//                }
//            }
//        }
//
//        var overall = 0
//        for each in temp {
//            overall += each
//        }
//
//        myersComp = overall/MBTI.count
    }
    
    func enneagramComp() {
        enneaComp = comp(people: enneagrams, type: "enneagram")
//        var temp = [Int]()
//        for person in 0..<enneagrams.count {
//            for other in 0..<enneagrams.count {
//                if person != other {
//                    let comp = csv.compareEnneagrams(yours: enneagrams[person], theirs: enneagrams[other])
//                    temp.append(Int(comp))
//                }
//            }
//        }
//
//        var overall = 0
//        for each in temp {
//            overall += each
//        }
//
//        enneaComp = overall/enneagrams.count
    }
    
}

