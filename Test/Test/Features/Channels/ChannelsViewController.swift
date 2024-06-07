//
//  ChannelsViewController.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import UIKit

protocol ChannelsViewControllerDelegate: AnyObject {
    func channelsViewControllerDidTapReview(_ viewController: ChannelsViewController)
}

class ChannelsViewController: UIViewController {
   
    private let viewModel: ChannelsViewModel
    private weak var delegate: ChannelsViewControllerDelegate?

    @IBOutlet weak var channelsTableView: UITableView!
    
    init(viewModel: ChannelsViewModel, delegate: ChannelsViewControllerDelegate) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Text.channels
        setupTableView()
        setupNavigationItem()
        loadData()
    }
    
    private func loadData() {
        viewModel.fetchChannels { [weak self] error in
            guard let self = self else { return }
            if let error {
                self.presentAlert(title: Text.Alert.error, message: error.localizedDescription, buttonTitle: Text.Alert.ok)
            } else {
                self.channelsTableView.reloadData()
            }
        }
    }
    
    @objc private func reviewTapped() {
        delegate?.channelsViewControllerDidTapReview(self)
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Text.review, style: .plain, target: self, action: #selector(reviewTapped))
    }

    private func setupTableView() {
        channelsTableView.register(UINib(nibName: ChannelCell.identifier, bundle: nil), forCellReuseIdentifier: ChannelCell.identifier)
    }
}

extension ChannelsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelCell.identifier, for: indexPath) as? ChannelCell else {
            return UITableViewCell()
        }
        cell.configureWith(viewModel: viewModel.cellViewModel(at: indexPath))
        return cell
    }
}

extension ChannelsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.selectChannel(at: indexPath)
    }
}
