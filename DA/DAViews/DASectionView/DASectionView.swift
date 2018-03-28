//
//  DASectionView.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/23/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import UIKit

import AlamofireImage


class DASectionView: XibView {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameLable: UILabel!
    
    
    
    override func awakeFromNib() {
        userImageView.layer.cornerRadius = userImageView.frame.size.height/2
        userNameLable.text = "Alok"
    }
    
    func populateHeaderView(userName: String, userImageString: String)  {
        userImageView.af_setImage(withURL: URL(string: userImageString)!, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        userNameLable.text = userName
        
    }
    
    

}
