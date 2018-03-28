//
//  DAFlickerRequest.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/25/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class DAFlickerRequest {
    struct DAFlickerKeys {
        static let status   = "status"
        static let message  = "message"
        static let users    = "data"
    }
    struct UsersKeys {
        static let hasMore   = "has_more"
        static let users  = "users"
    }
    struct UserKeys {
        static let name   = "name"
        static let imageUrlString  = "image"
        static let items    = "items"
    }
    let baseUrl = "http://sd2-hiring.herokuapp.com/api/users?"
    func fetchData(offset : Int, limit : Int, completion: @escaping (Bool?) -> Void)   {
        if  let aUrl = URL(string: "\(baseUrl)offset=\(offset)&limit=\(limit)") {
            Alamofire.request(aUrl).responseJSON(completionHandler: { (response) in
                if response.result.isSuccess{
                    let json = JSON(response.result.value as! [String : Any])
                    let usersDataDic  = json[DAFlickerKeys.users]
                    let userDataDic = usersDataDic[UsersKeys.users].arrayValue
                    let has_more = usersDataDic[UsersKeys.hasMore].bool
                    for parse in userDataDic {
                        let daUser  = DAUser()
                        daUser.userName = parse[UserKeys.name].stringValue
                        daUser.userImage = parse[UserKeys.imageUrlString].stringValue
                        daUser.hasMore = has_more!
                        let userItemsData = parse[UserKeys.items].arrayValue
                        for anItemUrlString in userItemsData{
                            let daUser_item = DAUserItem()
                            daUser_item.itemUrlString = anItemUrlString.stringValue
                            daUser.user_items.append(daUser_item)
                        }
                        let realm = try! Realm()
                        try! realm.write {
                            realm.add(daUser, update: true)
                        }
                    }
                    completion(has_more)
                }
            })
        }
    }
}
