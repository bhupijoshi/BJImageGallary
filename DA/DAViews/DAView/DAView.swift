//
//  DAView.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/23/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import UIKit
import RealmSwift


protocol DAViewDelegate: class {
    func fetchDataByPagination()
}


enum DACellType {
    case    None
    case    BigCell
    case    SmallCell
    case    MicroCell
}

class DAView: UIView, UITableViewDelegate,UITableViewDataSource {
    let bigCellIdentifier   = "BigCell"
    let smallCellIdentifier = "SmallCell"
    let microCellIdentifier = "MicroCell"
    var currentCellType = DACellType.None
    
    weak var delegate: DAViewDelegate?
    
    var users : Results<DAUser>?
    
    


    @IBOutlet weak var aTableView: UITableView!
   
    override func awakeFromNib() {
        aTableView.delegate     = self
        aTableView.dataSource   = self
        aTableView.separatorStyle = .none
        aTableView.allowsSelection = false
        aTableView.register(UINib.init(nibName: "DABigTableViewCell", bundle: nil), forCellReuseIdentifier: bigCellIdentifier)
        aTableView.register(UINib.init(nibName: "DASmallTableViewCell", bundle: nil), forCellReuseIdentifier: smallCellIdentifier)
        aTableView.register(UINib.init(nibName: "DAMicroTableViewCell", bundle: nil), forCellReuseIdentifier: microCellIdentifier)
        currentCellType = .None
    
       
    }
    
    func populateView(userList : Results<DAUser>)  {
        print("populateView")
        users = userList
        aTableView .reloadData()
        
    }
    
    //Table View Data Soure
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return users!.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users![section].user_items.count % 2 == 0 {
            return users![section].user_items.count/2
        }
        else{
            return users![section].user_items.count/2 + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            currentCellType = .None
        }
        if users![indexPath.section].user_items.count % 2 == 0 {
            currentCellType = .SmallCell
        }
        else if currentCellType == .BigCell || currentCellType == .MicroCell{
            currentCellType = .MicroCell
        }
        else{
            currentCellType = .BigCell
        }
        switch currentCellType {
        case .SmallCell:
            let aCell = tableView.dequeueReusableCell(withIdentifier: smallCellIdentifier, for: indexPath) as! DASmallTableViewCell
            aCell.populateSmallCell(firstImageUrlString: users![indexPath.section].user_items[indexPath.row].itemUrlString, secondImageUrlString: users![indexPath.section].user_items[indexPath.row+1].itemUrlString)
            return aCell
        case .BigCell:
            let aCell = tableView.dequeueReusableCell(withIdentifier: bigCellIdentifier, for: indexPath) as! DABigTableViewCell
            aCell.populateBigCell(firstImageUrlString: users![indexPath.section].user_items[indexPath.row].itemUrlString)
            return aCell
        case .MicroCell:
            let aCell = tableView.dequeueReusableCell(withIdentifier: microCellIdentifier, for: indexPath) as! DAMicroTableViewCell
             aCell.populateMicroCell(firstImageUrlString: users![indexPath.section].user_items[indexPath.row].itemUrlString, secondImageUrlString: users![indexPath.section].user_items[indexPath.row+1].itemUrlString)
        default:
            break
        }
        return UITableViewCell()
    }
    
    
    
    // View for Section
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let aSectionView = DASectionView().loadNib() as! DASectionView
        aSectionView.populateHeaderView(userName: users![section].userName, userImageString: users![section].userImage)
        return aSectionView
    }
    
    // Height for section view
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            currentCellType = .None
        }
        
        if users![indexPath.section].user_items.count % 2 == 0 {
            currentCellType = .SmallCell
        }
        else if currentCellType == .BigCell || currentCellType == .MicroCell{
            currentCellType = .MicroCell
        }
        else{
            currentCellType = .BigCell
        }
        
        var rowHeight : CGFloat!
        switch currentCellType {
        case .SmallCell:
            rowHeight =  150
        case .BigCell:
            rowHeight = 300
        case .MicroCell:
            rowHeight = 120
        default:
            break
        }
        return rowHeight;
    }
    
    // Height for Cell
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            currentCellType = .None
        }
        
        if users![indexPath.section].user_items.count % 2 == 0 {
            currentCellType = .SmallCell
        }
        else if currentCellType == .BigCell || currentCellType == .MicroCell{
            currentCellType = .MicroCell
        }
        else{
            currentCellType = .BigCell
        }
        
        var rowHeight : CGFloat!
        switch currentCellType {
        case .SmallCell:
            rowHeight =  150
        case .BigCell:
            rowHeight = 300
        case .MicroCell:
            rowHeight = 120
        default:
            break
        }
        return rowHeight;
    }

    
    // Pagination Code
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == (users?.count)! - 1 {
            if users![indexPath.section].hasMore{
                delegate?.fetchDataByPagination()
            }
        }
    }
    
    

}
