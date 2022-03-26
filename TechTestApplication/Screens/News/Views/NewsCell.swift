//
//  NewsCell.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import UIKit

class NewsCell: UITableViewCell{
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
