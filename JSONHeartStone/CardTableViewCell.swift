//
//  CardTableViewCell.swift
//  JSONHeartStone
//
//  Created by 李泰儀 on 2019/5/17.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
