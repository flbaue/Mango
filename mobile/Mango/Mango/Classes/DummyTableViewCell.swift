//
//  TableViewCell.swift
//  Mango
//
//  Created by Florian Bauer on 29.12.15.
//  Copyright © 2015 Florian Bauer. All rights reserved.
//

import UIKit

class DummyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dummyView: DummyView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        dummyView.text = ""
    }
}
