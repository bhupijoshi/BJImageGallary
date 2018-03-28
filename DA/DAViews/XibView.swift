//
//  XibView.swift
//  DA
//
//  Created by Bhoopendra Joshi on 3/23/18.
//  Copyright © 2018 Bhoopendra Joshi. All rights reserved.
//

import UIKit
class XibView: UIView {

}
extension UIView {
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
}
