//
//  CampaignsViewController.swift
//  Test
//
//  Created by Adrian Pandelea on 28.05.2024.
//

import UIKit

class CampaignsViewController: UIViewController {

    private var addCampaignButton: UIBarButtonItem?
    private let viewModel: CampaignsViewModel!
    @IBOutlet weak var campaignsTableView: UITableView!

    init(viewModel: CampaignsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Text.campaigns
        setupNavigationItem()
        setupTableView()
        loadData()
    }
    
    private func loadData() {
        viewModel.makeCampaignCellViewModels()
        campaignsTableView.reloadData()
    }
    
    private func setupNavigationItem() {
        addCampaignButton = UIBarButtonItem(title: Text.addCampaign, style: .plain, target: self, action: #selector(addCampaignTapped))
        addCampaignButton?.isEnabled = false
        navigationItem.rightBarButtonItem = addCampaignButton
    }
        
    private func setupTableView() {
        campaignsTableView.register(UINib(nibName: CampaignCell.identifier, bundle: nil), forCellReuseIdentifier: CampaignCell.identifier)
    }
    
    @objc private func addCampaignTapped() {
        viewModel.addSelectedCampaign()
    }
}

extension CampaignsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CampaignCell.identifier, for: indexPath) as? CampaignCell else {
            return UITableViewCell()
        }
        cell.configureWith(viewModel: viewModel.cellViewModel(at: indexPath))
        return cell
    }
}

extension CampaignsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCampaignAtIndexPath(indexPath)
        addCampaignButton?.isEnabled = viewModel.isAddCampaignButtonEnabled
    }
}
