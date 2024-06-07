//
//  CampaignCellViewModel.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import Foundation

class CampaignCellViewModel {
        
    private let campaign: Campaign
    
    init(campaign: Campaign) {
        self.campaign = campaign
    }
    
    var details: String {
        campaign.details
    }
    
    var price: String {
        "\(String(campaign.monthlyFee))  \(campaign.currency)"
    }
}
