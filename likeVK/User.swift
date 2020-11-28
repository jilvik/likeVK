//
//  User.swift
//  likeVK
//
//  Created by Jambau on 05.11.2020.
//

import Foundation
import UIKit

class User: NSObject {
    var id: String?
    var profilePhoto: UIImage
    var name: String
    var surname: String
    var summary: String?
    var isOnline: Bool?
    var gender: Gender
    var city: String?
    var degree: String?
    var workplace: String?
    var followersCount: Int?
    var feeds: [FeedItem]?
    
    init(profilePhoto: UIImage, name: String, surname: String, gender: Gender) {
        self.profilePhoto = profilePhoto
        self.name = name
        self.surname = surname
        self.gender = gender
    }
}

enum Gender {
    case male
    case female
}
