//
//  TargetSpecificCell.swift
//  Test
//
//  Created by Adrian Pandelea on 27.05.2024.
//

import UIKit

class TargetSpecificCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(viewModel: TargetSpecificCellViewModel) {
        titleLabel?.text = viewModel.title
    }
    
}
