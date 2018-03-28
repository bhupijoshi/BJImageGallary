//
//  DABigTableViewCell.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/23/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import UIKit

class DABigTableViewCell: UITableViewCell {

    @IBOutlet weak var anImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateBigCell(firstImageUrlString: String)
    {
        anImageView.image = UIImage(named: "default-user-image")
        anImageView.af_setImage(withURL: URL(string: firstImageUrlString)!, placeholderImage: nil, filter: nil,  imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
}
