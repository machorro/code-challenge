//
//  StoryTableViewCell.swift
//  Code Challenge
//
//  Copyright © 2019 Code Coding Challenge. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "StoryCellIdentifier"

    @IBOutlet private weak var authorAvatarContainerView: UIView!
    @IBOutlet weak var authorAvatarImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var didTapCoverImage: () -> Void = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundView(authorAvatarImageView)
        dropShadow(authorAvatarContainerView)
        roundedCorners(coverImageView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(coverTap))
        coverImageView.addGestureRecognizer(tap)
        coverImageView.isUserInteractionEnabled = true
    }
    
    @objc private func coverTap() {
        didTapCoverImage()
    }
}
