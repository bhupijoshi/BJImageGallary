//
//  DASmallTableViewCell.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/23/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import UIKit

class DASmallTableViewCell: UITableViewCell {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateSmallCell(firstImageUrlString: String, secondImageUrlString: String)
    {
        firstImageView.image = UIImage(named: "default-user-image")
        secondImageView.image = UIImage(named: "default-user-image")
        firstImageView.af_setImage(withURL: URL(string: firstImageUrlString)!, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        secondImageView.af_setImage(withURL: URL(string: secondImageUrlString)!, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
