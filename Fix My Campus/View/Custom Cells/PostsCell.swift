//
//  PostsCell.swift
//  Fix My Campus
//
//  Created by Grant Kim on 12/21/17.
//  Copyright © 2017 2.5 Yellow. All rights reserved.
//

import UIKit

class PostsCell: UITableViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
