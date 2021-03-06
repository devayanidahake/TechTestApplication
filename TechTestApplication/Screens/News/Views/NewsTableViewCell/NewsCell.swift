//
//  NewsCell.swift
//  TechTestApplication
//
//  Created by Devayani Purandare on 24/03/22.
//

import Foundation
import SDWebImage
import UIKit

protocol NewsCellAppearanceProtocol {
    func updateCellProperties(cellViewModel: NewsCellViewModel)
}

class NewsCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet private var title: UILabel!
    
    @IBOutlet private var imageV: UIImageView!
    
    @IBOutlet private var author: UILabel!
    
    class var identifier: String { return String(describing: self) }
    
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: NewsCellViewModel?
    
    
    // MARK: Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureView() {
        // Cell view customization
        backgroundColor = .clear
        
        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
        
        // Cell label properties
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
        self.author.numberOfLines = 0
        self.author.lineBreakMode = .byWordWrapping
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
extension NewsCell: NewsCellAppearanceProtocol {
    func updateCellProperties(cellViewModel: NewsCellViewModel) {
        self.title.text = cellViewModel.title
        self.author.text = cellViewModel.author
        if let imageURL = URL(string: cellViewModel.imageUrl) {
            self.imageV.contentMode = .scaleAspectFill
            self.imageV.sd_setImage(with: imageURL,
                                    placeholderImage: UIImage(named: Constants.Image.placeholderImage),
                                    options: .transformAnimatedImage, context: nil)
        }
    }
}
