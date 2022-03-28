//
//  NewsCell.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var author: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: NewsCellViewModel? {
        didSet {
            self.title.text = cellViewModel?.title ?? ""
            self.author.text = cellViewModel?.author ?? ""
            if let urlstring = cellViewModel?.imageUrl , let imageURL = URL.init(string: urlstring){
                self.imageV.contentMode = .scaleAspectFill
                self.imageV.sd_setImage(with: imageURL, placeholderImage: nil, options: .transformAnimatedImage, context: nil)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        //Cell label properties
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        self.author.numberOfLines = 0
        self.author.lineBreakMode = .byWordWrapping
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
