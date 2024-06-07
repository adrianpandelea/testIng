//
//  ChannelCell.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import UIKit

class ChannelCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(viewModel: ChannelCellViewModel) {
        titleLabel?.text = viewModel.title
    }

}
