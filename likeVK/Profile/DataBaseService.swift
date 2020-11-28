//
//  FriednsListService.swift
//  likeVK
//
//  Created by Jambau on 05.11.2020.
//

import Foundation
import UIKit

class DataBaseService {
    var important = [User]()
    var potential = [User]()
    var myFriends = [User]()
    var friendRequestes = [User]()
    var myself = User(profilePhoto: UIImage(named: "guy-profile")!, name: "Alex", surname: "Pro", gender: .male)
    
    static var commonService: DataBaseService = {
        let instance = DataBaseService()
        return instance
    }()
    
    private init() {
        addMyself()
        addUsers()
    }
    
    private func addMyself() {
        myself.summary = "This is my first test project"
        myself.city = "Moscow"
        myself.degree = "MSU"
        myself.workplace = "ORB"
        myself.followersCount = 150
        
        var feeds = [FeedItem]()
        let feedItem = FeedItem()
        feedItem.image = UIImage(named: "car")
        feedItem.publicationDate = Date()
        feedItem.text = "Test text for feed"
        feedItem.likeCount = 30
        feeds.append(feedItem)
        feeds.append(feedItem)
        myself.feeds = feeds
    }
    
    private func addUsers() {
        let noPhoto = UIImage(named: "no-photo")!
        let firstMan = User(profilePhoto: noPhoto, name: "First", surname: "Man", gender: Gender.male)
        firstMan.city = "Moscow"
        important.append(firstMan)
        important.append(
            User(profilePhoto: noPhoto, name: "Second", surname: "Man", gender: Gender.male))
        important.append(
            User(profilePhoto: noPhoto, name: "Third", surname: "Man", gender: Gender.male))
        important.append(
            User(profilePhoto: noPhoto, name: "Fourth", surname: "Man", gender: Gender.male))
        let firstWoman = User(profilePhoto: noPhoto, name: "First", surname: "Woman", gender: Gender.female)
        firstWoman.city = "London"
        important.append(firstWoman)
        
        potential.append(
            User(profilePhoto: noPhoto, name: "Second", surname: "Woman", gender: Gender.female))
        potential.append(
            User(profilePhoto: noPhoto, name: "Fifth", surname: "Man", gender: Gender.male))
        potential.append(
            User(profilePhoto: noPhoto, name: "Sixth", surname: "Man", gender: Gender.male))
        potential.append(
            User(profilePhoto: noPhoto, name: "Seventh", surname: "Man", gender: Gender.male))
        
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Eighth", surname: "Man", gender: Gender.male))
        let thirdWoman = User(profilePhoto: noPhoto, name: "Third", surname: "Woman", gender: Gender.female)
        thirdWoman.city = "Almaty"
        myFriends.append(thirdWoman)
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Fourth", surname: "Woman", gender: Gender.female))
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Nineth", surname: "Man", gender: Gender.male))
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Fifth", surname: "Woman", gender: Gender.female))
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Sixth", surname: "Woman", gender: Gender.female))
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Seventh", surname: "Woman", gender: Gender.female))
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Eighth", surname: "Woman", gender: Gender.female))
        myFriends.append(
            User(profilePhoto: noPhoto, name: "Nineth", surname: "Woman", gender: Gender.female))
        
        friendRequestes.append(
            User(profilePhoto: noPhoto, name: "Bob", surname: "Marley", gender: Gender.male))
        friendRequestes.append(
            User(profilePhoto: noPhoto, name: "Tereza", surname: "Mom", gender: Gender.female))
        friendRequestes.append(
            User(profilePhoto: noPhoto, name: "Kaco", surname: "Itochel", gender: Gender.male))
        friendRequestes.append(
            User(profilePhoto: noPhoto, name: "Malen", surname: "Kyhren", gender: Gender.male))
        
    }
}
