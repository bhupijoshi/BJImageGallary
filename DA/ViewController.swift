//
//  ViewController.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/22/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

class ViewController: UIViewController,DAViewDelegate {
   
    let realm = try! Realm()   //Realm Object
    var aView : DAView?
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aView = self.view as? DAView
        aView?.delegate = self
        reloadTableView()
        fetchFlickerData()
    }

    func fetchFlickerData() {
        isLoading = true
        let dataRequest = DAFlickerRequest()
        var currentOffset = UserDefaults.standard.integer(forKey: "Offset")
        dataRequest.fetchData(offset: currentOffset, limit: 10) { (flickerObject) in
            if flickerObject != nil{
                DispatchQueue.main.async {
                    currentOffset = currentOffset + 10
                    UserDefaults.standard.set(currentOffset, forKey: "Offset")
                    self.reloadTableView()
                    }
            }
        }
    }

    //Reload table view
    func reloadTableView()  {
        isLoading = false
        let  result  = realm.objects(DAUser.self)
        aView?.populateView(userList: result)
    }
    
    
    //DAView Delegate
    func fetchDataByPagination() {
        if isLoading {
            return
        }
        else{
            fetchFlickerData() //fetch data from server
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

