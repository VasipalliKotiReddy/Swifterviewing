//
//  AlbumTableCell.swift
//  Swifterviewing
//
//  Created by Koti Reddy , Vasipalli on 15/07/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import UIKit
class AlbumTableCell: UITableViewCell {
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var albumImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


