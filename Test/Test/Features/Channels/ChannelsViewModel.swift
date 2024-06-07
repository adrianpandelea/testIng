//
//  ChannelsViewModel.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import Foundation

protocol ChannelsViewModelDelegate: AnyObject {
    func channelsViewControllerDidTapReview(_ viewController: ChannelsViewController)
    func channelsViewModel(_ viewModel: ChannelsViewModel, didSelectChannel _channel: Channel)
}

class ChannelsViewModel {
    private var channels: [Channel] = []
    private var channelCellViewModels: [ChannelCellViewModel] = []
    private let selectedChannelsIDs: Set<Int>
    private let channelsService: ChannelsServiceProtocol
    private weak var delegate: ChannelsViewModelDelegate?

    init (selectedChannelsIDs: Set<Int>, channelsService: ChannelsServiceProtocol = ChannelsService(), delegate: ChannelsViewModelDelegate) {
        self.selectedChannelsIDs = selectedChannelsIDs
        self.channelsService = channelsService
        self.delegate = delegate
    }
    
    private func makeChannelCellViewModels() {
        channelCellViewModels = channels.map { ChannelCellViewModel(title: $0.name) }
    }

    var numberOfRows: Int {
        channelCellViewModels.count
    }
        
    func cellViewModel(at indexPath: IndexPath) -> ChannelCellViewModel {
        channelCellViewModels[indexPath.row]
    }
    
    func selectChannel(at indexPath: IndexPath) {
        delegate?.channelsViewModel(self, didSelectChannel: channels[indexPath.row])
    }
    
    func fetchChannels(completion: @escaping (Error?) -> ()) {
        channelsService.fetchChannels { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let channels):
                    self.channels = channels.filter { self.selectedChannelsIDs.contains($0.id)}
                    self.makeChannelCellViewModels()
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
            }
        }
    }
}
