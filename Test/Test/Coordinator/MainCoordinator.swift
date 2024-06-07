//
//  RootCoordinator.swift
//  Test
//
//  Created by Adrian Pandelea on 03.06.2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

class MainCoordinator: Coordinator  {
    var navigationController: UINavigationController
    private var selectedCampaigns: [Campaign]  = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let targetSpecificsViewModel = TargetSpecificsViewModel(delegate: self)
        let targetSpecificsViewController = TargetSpecificsViewController(viewModel: targetSpecificsViewModel)
        navigationController.pushViewController(targetSpecificsViewController, animated: true)
    }
    
    func showChannels(for specifics: [TargetSpecific]) {
        guard specifics.count > 0  else {
            navigationController.presentAlert(title: Text.Alert.error, message: Text.noSpecificsSelected, buttonTitle: Text.Alert.ok)
            return
        }
        let channelsSet = specifics.first?.availableChannels
        let channelsIDs = specifics.reduce(channelsSet) { $0?.intersection($1.availableChannels)}
        guard let channelsIDs else { return }
        let channelsViewModel = ChannelsViewModel(selectedChannelsIDs: channelsIDs, delegate: self)
        let channelsViewController = ChannelsViewController(viewModel: channelsViewModel, delegate: self)
        navigationController.pushViewController(channelsViewController, animated: true)
      }
      
    func showCampaigns(for channel: Channel) {
        let campaignViewModel = CampaignsViewModel(campaigns: channel.campaigns, delegate: self)
        let campaignsViewController = CampaignsViewController(viewModel: campaignViewModel)
        navigationController.pushViewController(campaignsViewController, animated: true)
    }
    
    func showReview() {
        guard selectedCampaigns.count > 0 else {
            navigationController.presentAlert(title: Text.Alert.error, message: Text.noCampaignsSelected, buttonTitle: Text.Alert.ok)
            return
        }
        let reviewViewModel = ReviewViewModel(campaigns: selectedCampaigns)
        let reviewViewController = ReviewViewController(viewModel: reviewViewModel)
        navigationController.pushViewController(reviewViewController, animated: true)
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}

extension MainCoordinator: CampaignsViewModelDelegate {
    func campaignsViewModel(_ viewModel: CampaignsViewModel, didAddCampaign campaign: Campaign) {
        selectedCampaigns.append(campaign)
        goBack()
    }
}

extension MainCoordinator: ChannelsViewModelDelegate {
    func channelsViewModel(_ viewModel: ChannelsViewModel, didSelectChannel channel: Channel) {
        showCampaigns(for: channel)
    }
}

extension MainCoordinator: ChannelsViewControllerDelegate {
    func channelsViewControllerDidTapReview(_ viewController: ChannelsViewController) {
        showReview()
    }
}

extension MainCoordinator: TargetSpecificsViewModelDelegate {
    func targetSpecificsViewModel(_ vieModel: TargetSpecificsViewModel, didSelectSpecifics selectedSpecifics: [TargetSpecific]) {
        showChannels(for: selectedSpecifics)
    }
}
