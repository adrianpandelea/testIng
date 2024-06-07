//
//  CampaignCell.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import UIKit

class CampaignCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(viewModel: CampaignCellViewModel) {
        priceLabel.text = viewModel.price
        detailsLabel.text = viewModel.details
    }

}
