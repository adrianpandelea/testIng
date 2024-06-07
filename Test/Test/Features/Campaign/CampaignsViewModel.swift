//
//  CampaignsViewModel.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import Foundation

protocol CampaignsViewModelDelegate: AnyObject {
    func campaignsViewModel(_ viewModel: CampaignsViewModel, didAddCampaign _campaign: Campaign)
}

class CampaignsViewModel {
    private let campaigns: [Campaign]
    private var campaignCellViewModels: [CampaignCellViewModel] = []
    private (set) var selectedCampaign: Campaign?
    private weak var delegate: CampaignsViewModelDelegate?
    
    init(campaigns: [Campaign], delegate: CampaignsViewModelDelegate) {
        self.campaigns = campaigns
        self.delegate = delegate
    }

    var numberOfRows: Int {
        campaignCellViewModels.count
    }
    
    var isAddCampaignButtonEnabled: Bool {
        selectedCampaign != nil
    }
    
    func cellViewModel(at indexPath: IndexPath) -> CampaignCellViewModel {
        campaignCellViewModels[indexPath.row]
    }

    func makeCampaignCellViewModels() {
        campaignCellViewModels = campaigns.map { CampaignCellViewModel(campaign: $0) }
    }
        
    func selectCampaignAtIndexPath(_ indexPath: IndexPath) {
        let campaign = campaigns[indexPath.row]
        if selectedCampaign == campaign {
            selectedCampaign = nil
        } else {
            selectedCampaign = campaigns[indexPath.row]
        }
    }
    
    func addSelectedCampaign() {
        if let selectedCampaign {
            delegate?.campaignsViewModel(self, didAddCampaign: selectedCampaign)
        }
    }
}
