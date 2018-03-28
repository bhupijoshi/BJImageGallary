//
//  DADataSummary.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/22/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import Foundation
import RealmSwift
class DAUser: Object {
    @objc dynamic var userName = ""
    @objc dynamic var userImage = ""
    @objc dynamic var hasMore   =  false
    var user_items = List<DAUserItem>()
    override static func primaryKey() -> String? {
        return "userName"
    }
}

class DAUserItem : Object {
    @objc dynamic var itemUrlString = ""
    override static func primaryKey() -> String? {
        return "itemUrlString"
    }
}









