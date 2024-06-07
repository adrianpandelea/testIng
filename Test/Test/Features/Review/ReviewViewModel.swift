//
//  ReviewViewModel.swift
//  Test
//
//  Created by Adrian Pandelea on 05.06.2024.
//

import Foundation

class ReviewViewModel {
    private let campaigns: [Campaign]
    private var campaignCellViewModels: [CampaignCellViewModel] = []
    
    init(campaigns: [Campaign]) {
        self.campaigns = campaigns
    }
    
    var numberOfRows: Int {
        campaignCellViewModels.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CampaignCellViewModel {
        campaignCellViewModels[indexPath.row]
    }
    
    func makeCampaignCellViewModels() {
        campaignCellViewModels = campaigns.map { CampaignCellViewModel(campaign: $0) }
    }
    
    var emailBody: String {
        campaigns.reduce("") { $0 + "\($1.monthlyFee) \($1.currency) \($1.details) \n" }
    }
}
